# Enable the per-domain context on a Config Pages type (configure)

There is no settings page for this module. You turn per-domain values on **per Config Pages type**,
inside config_pages' own type form. Everything below is UI/config owned by `config_pages`; this
module only contributes the `domain` context option and its `fallback` schema key.

## Steps

1. Install both dependencies and this module: `config_pages`, `domain`, `domain_config_pages`.
2. Have a Config Pages type (create one at `/admin/structure/config_pages/types/add`, add fields to it).
3. Edit the type at **`/admin/structure/config_pages/types/manage/{config_pages_type}`**
   (route `entity.config_pages_type.edit_form`, requires entity access `config_pages_type.update` —
   in practice the `administer config_pages types` permission).
4. In the type form's **Context** section, tick **Domain** (the `domain` context) so a distinct value
   set is stored per active domain.
5. Optionally set the **fallback** for the Domain context — what a domain with no saved value of its
   own is served. This is written to config as `context.fallback.domain` (see below).
6. Editors then set values per domain by editing the Config Pages entity
   (`/admin/structure/config_pages/{config_pages}`, entity access `config_pages.update` /
   `edit config_pages entity`) **while browsing on that domain** — the active domain (from
   `domain.negotiator`) selects which value set they are editing.

## What gets stored

On the `config_pages.type.<id>` config object, config_pages persists the context selection under
`context.group` and the fallback under `context.fallback.<context_id>`. This module's schema alter
makes `context.fallback.domain` a valid typed string, e.g.:

```yaml
# config_pages.type.<id>.yml (excerpt)
context:
  group:
    domain: domain          # the 'domain' context is enabled for this type
  fallback:
    domain: default_domain  # optional: fallback domain id for domains without their own value
  show_warning: true
```

## Cache / fallback notes an agent should honor

- The value returned by the context is the **active domain id**, so any render output built from a
  per-domain Config Pages value must vary by domain (cache context) or one domain can be served
  another domain's value.
- The **fallback** is a real decision, not cosmetic: with no fallback a new domain gets an empty/field
  default; with a fallback it inherits another domain's value. Choose it before adding the second
  domain.

Related: the plugin contract and the schema alter are documented in
[../api/context-plugin.md](../api/context-plugin.md).
