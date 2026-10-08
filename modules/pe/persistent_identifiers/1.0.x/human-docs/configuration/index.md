# Configuration

Configuring Persistent Identifiers happens in two places: the **permission** that
decides who may mint, and the **settings form** where you choose a minter/persister
and enter provider options.

## 1. Grant the mint permission

1. Log in as a user with **Administer permissions**.
2. Go to **People → Permissions** (`/admin/people/permissions`).
3. Tick **Mint persistent identifiers** for the roles that should be allowed to
   create identifiers on nodes (typically editors or repository managers).
4. Click **Save permissions**.

Only users with this permission see the minting control on the node add/edit
form.

## 2. Open the settings form

Go to **Configuration → Persistent Identifiers → Settings**
(`/admin/config/persistent_identifiers/settings`). What you see here is
deliberately open‑ended: the framework contributes a few general options, and
**each enabled minter adds its own fields** to the same form. Consult the README
of the specific minter you installed for the exact meaning of its fields — they
vary by registration authority (CrossRef, DataCite, EZID, Handle, and so on).

### Choose a minter and a persister

- **Minter** — the service that creates the identifier by talking to a
  registration authority. Pick the one that corresponds to the minter module you
  enabled.
- **Persister** — where the minted value is stored on the node. The bundled
  option writes the identifier to a **generic text field**, so make sure that
  target field exists on the content types you plan to mint for.

### Optional: expose the identifier in JSON‑LD

The form offers an option to add the persistent identifier to a node's JSON‑LD,
mapped to `schema:sameAs`. If you tick it and set a **resolver base URL** (for
example `https://example.com/ids`), the node's JSON‑LD gains a `sameAs` entry
pointing at the resolvable identifier URL — useful for making your content
discoverable and citable by external systems.

## 3. Provider credentials — treat them as secrets

Registration authorities (DataCite, EZID, and the like) require **account
credentials or API keys** to mint identifiers. These are entered through the
minter's fields on the settings form. Treat any such credential as a **secret**:

- Prefer supplying it from an environment variable rather than typing it into a
  form that ends up in exported configuration. With DDEV you can store the value
  with `ddev dotenv set .ddev/.env --my-credential=<value>` (keep `.ddev/.env`
  out of version control) and reference it from `settings.php`, or use the **Key**
  module where the minter supports it.
- Never commit a live credential to your repository, and make sure the minter
  talks to the authority over **HTTPS**.

## Minting a persistent identifier

Once configured, open any node the persister's target field applies to. Users
with *Mint persistent identifiers* will see the minting control at the bottom of
the node add/edit form; minting creates the identifier through the selected
minter and stores it via the selected persister. Some minter modules (the
DataCite DOI minter, for example) also offer batch minting through Views Bulk
Operations.
