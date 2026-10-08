# Peak Web Agent — manual setup guide

**Peak Web Agent** (`peak_web_agent`) adds a guardrailed AI sub‑agent — a "Web
Design Editor" minion — that lets you edit the **copy and images** of existing
pages just by chatting in plain language. It is part of the **Drup‑AID** project
(the Composer package is `drupal/drup_aid`) and the broader Peak Stack: requests
you type are routed by the Drup‑AID "Master Agent" to this sub‑agent, which makes
the edits.

The guardrails are the point. This agent is **content‑values only**: it edits the
text and images on a page and nothing more. It cannot delete content, and it cannot
change your site's structure. And because every change it makes is saved as a
normal Drupal **revision**, anything it does is reviewable and fully rollback‑able —
you are never one bad prompt away from an unrecoverable state.

Under the hood it runs on the **AI Agents** framework and is gated by the Drup‑AID
"cockpit" permission, so only authorised users can drive it. The connection to a
large language model — and the API key for it — is handled by the **AI** module,
which reads the key from an environment variable rather than storing it in plain
configuration. Bear in mind that, like any LLM integration, using the agent sends
your prompts and the relevant page content to the configured AI provider; review
the guardrails, the provider you choose, and the resulting revisions to be sure the
behaviour fits your site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the Drup‑AID package with
   Composer, enable this sub‑agent alongside the AI and AI Agents modules, and make
   sure an AI provider is configured.

There is no dedicated settings form for this sub‑agent — its AI provider and key
are configured through the **AI** module, and access is controlled by the Drup‑AID
cockpit permission. Setup is covered in [Installation](installation/index.md).

## Where it lives in the admin menu

Peak Web Agent has no settings page of its own. You reach it through the **Drup‑AID
cockpit** (the chat interface provided by the parent project), where you type your
editing request and the Master Agent routes it to the Web Design Editor. The AI
provider and key that power it are managed under the **AI** module's configuration.

## How to use it

1. Make sure an AI provider is set up in the **AI** module and that your user has
   the Drup‑AID cockpit permission (see [Installation](installation/index.md)).
2. Open the Drup‑AID cockpit / chat interface.
3. Describe the change you want in plain language — for example, rewording a
   paragraph or swapping an image on an existing page.
4. The Master Agent routes your request to the Web Design Editor, which applies the
   change as a new revision. Review the revision, and roll it back from the node's
   **Revisions** tab if you are not happy with it.
