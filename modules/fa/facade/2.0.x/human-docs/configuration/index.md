# Configuration

Setting up Façade has three parts: the framework settings form, the tenant model
(types and permissions), and — if you use remote workers — bearer‑token
authentication. Because Façade is a framework, the exact fields you see depend on
the launch plugin and provider you wire in; this page describes the pieces the
module itself provides.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Web services → Façade**, or navigate directly to
   `/admin/config/services/facade`.

This is the framework's central settings form (`facade.settings`). Use it to
configure how Façade connects to and drives your chosen orchestrator; the specific
options are supplied by the provider/launch plugin you have installed (the
reference implementation targets an OpenStack Cloud Orchestrator on Amazon
EC2/CloudFormation via the Cloud module).

## Define a Tenant type

Before you can create tenants you need at least one **Tenant type** — a
configuration entity that acts as a bundle for tenant entities, with its own
settings. Create your Tenant types first; each one you add automatically
generates its own per‑bundle permissions so you can grant access to specific
tenant types independently.

## Grant tenant permissions

On **People → Permissions**, Façade adds a set of tenant permissions:

- **Add tenant** — create new tenant entities.
- **View / Edit / Delete tenant entities** — the standard content operations on
  tenants.
- **Administer tenant entities** — full administrative control. This is a
  restricted, high‑trust permission; grant it only to trusted administrators.
- **Per‑bundle permissions** — generated automatically for each Tenant type you
  define, so you can scope access to individual tenant types.

Grant the narrowest set of permissions each role actually needs.

## Remote worker authentication (submodule)

If you enabled **Façade Remote Worker**, each remote worker authenticates back to
the control site with a **bearer token** stored on its user account (in the
`field_bearer_token` field). To set one up:

1. Create or choose the user account the remote worker will act as.
2. Populate that account's bearer‑token field with a strong, unique token.
3. Configure the remote worker to send that token when it calls the REST endpoint
   that returns its cloud configuration.

Treat these tokens as secrets: one per worker, never committed to version control,
and rotated if exposure is suspected.

## Managing tenants

Once types and permissions are in place, manage tenants through their entity list
and add/edit/delete forms. Creating, editing, or deleting a tenant is what fires
the launch‑tenant plugin, so those operations are also what provision or tear down
the corresponding remote resources — treat a tenant delete as a real teardown, not
just a database change.
