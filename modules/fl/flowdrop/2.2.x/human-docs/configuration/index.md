# Configuration

FlowDrop's configuration has five parts to set up deliberately: the **settings
form**, the **permissions** (including the new confirmation-policy permission),
**secrets** handling, the **confirmation gate** for side-effecting nodes, and the
**trusted-publisher** model that governs importing workflows.

## The settings form

FlowDrop does not declare a `configure` route in its info file, but its settings
form lives at:

> **`/admin/flowdrop/config/flowdrop`** (`FlowDropSettingsForm`)

There you set logging verbosity, whether to log to watchdog, the default
orchestrator, and the icon picker. Runtime secret settings live separately under
the `flowdrop_runtime` submodule (`SecretSettingsForm`).

## Permissions

FlowDrop separates its permissions so different responsibilities can be held by
different people. Assign them at **People → Permissions**:

| Permission | What it allows |
|-----------|----------------|
| **administer flowdrop** *(restricted)* | Full administration of FlowDrop. |
| **administer flowdrop configuration** | Manage FlowDrop configuration. |
| **administer flowdrop trusted publishers** *(restricted)* | Decide which publishers are trusted for importing signed workflow bundles. |
| **administer flowdrop confirmation policy** *(restricted)* | Govern which node types require operator confirmation, and who may waive it (new in the 2.x confirmation work). |
| **import flowdrop_workflow** | Import signed workflows from trusted publishers. |
| **import untrusted flowdrop_workflow** | Bypass trust verification to import an unsigned/untrusted workflow — grant with great care. |

The restricted permissions are security-sensitive; grant them only to highly
trusted roles. Deciding **who may grant trust**, **who governs the confirmation
gate**, and **who may build workflows** are three distinct decisions, which is why
they are three distinct permissions.

## Secrets — keep credentials out of config

Workflows call AI models and external APIs. **Do not** put keys into node
configuration or workflow config (which exports to YAML and lands in git). With the
**Key** module installed, reference secrets with the `${{ secrets.NAME }}` syntax —
the value resolves at runtime and never lands in workflow config or job records.

On a DDEV site:

```bash
ddev dotenv set .ddev/.env --openai-api-key=YOUR_KEY   # never commit .ddev/.env
ddev restart
ddev composer require drupal/key
ddev drush en key -y
ddev exec 'test -n "$OPENAI_API_KEY"'   # exit status 0 means it is set
ddev drush key:save openai_api_key --label='OpenAI API Key' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"OPENAI_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Then reference that Key via `${{ secrets.openai_api_key }}` (or the name you
configure) in your nodes. Note the gate (below) redacts resolved secret values from
the persisted confirmation prompt while still binding the real values in its consent
hash.

## The confirmation gate (human-in-the-loop)

New in 2.1 → 2.2: a node type can require **operator approval before a
side-effecting node runs** — this covers both graph-scheduled nodes and nodes an AI
agent calls as tools mid-turn (for example, "send this email"). Configuration is
governed by the **administer flowdrop confirmation policy** permission and expressed
as a `confirmation` map on the node type:

- **Policy** — *ask* (always require approval), *skip* (never), or **derive from
  side effects** (require approval when the node declares it has side effects).
- **Allow-lists** — author-control and runtime-control lists for who may set or
  waive confirmation.

The gate is deliberately hardened, and these behaviours are worth knowing:

- **Atomic consent.** Approval is consumed under a lock, so one approval can never
  authorise two executions.
- **Expiry, fail-closed.** Gate questions expire (default **72 hours**,
  `gate_expiry`); an expired question cancels the abandoned run rather than letting
  it through.
- **Errors, don't ungate.** If side-effect derivation cannot resolve a plugin, it
  errors rather than silently letting the node run ungated.
- **Secret redaction.** Resolved `${{ secrets.* }}` values are redacted from the
  persisted gate prompt.

Decide which node types must be gated, set the policy accordingly, and keep the
confirmation-policy permission with a small, trusted group.

## Outbound HTTP and the SSRF guard

HTTP nodes (and the interrupt submodule's call-and-wait node) validate any
caller-supplied URL automatically: **http/https only**, DNS resolved with the
request pinned to the resolved IP (closing the DNS-rebinding window), redirects
re-validated per hop, and **internal targets refused** unless
`allow_internal_requests` is explicitly set on the node. TLS certificate
verification is left on (Guzzle's default). Enable `allow_internal_requests` only
when a workflow genuinely needs to reach an internal service, and understand you are
opting out of that protection for that node.

## Importing workflows — the trusted-publisher model

Workflows export as **bundles** and can be imported, which is a supply-chain
decision since an imported workflow can call models, make HTTP requests, and touch
content. FlowDrop's model:

1. A publisher is a **`FlowDropTrustedPublisher`** entity holding its publisher key.
2. Signed bundles are **verified against that key before import**.
3. Trusting a publisher is explicit and gated behind **administer flowdrop trusted
   publishers**; importing trusted bundles uses **import flowdrop_workflow**.
4. Bypassing verification requires the separate **import untrusted flowdrop_workflow**
   permission — grant it only in exceptional, well-understood cases.

As the permission's own text puts it: *"Granting trust to a publisher allows its
signed bundles to be imported."* Keep the trusted list small and vetted.

## Cost and egress

Every AI-model node and HTTP node makes an **outbound** call that may cost money and
sends data off your site. Review what each workflow reaches out to, use the
confirmation gate on the risky ones, and keep an eye on model/API spend.

## Building and operating workflows

Build automations in the visual editor, then operate them from the CLI as well:
FlowDrop ships **Drush commands** for workflow bundles, pipeline traces, and trigger
tests. Export finished workflows with `drush cex` to version them in git and deploy
across environments.
