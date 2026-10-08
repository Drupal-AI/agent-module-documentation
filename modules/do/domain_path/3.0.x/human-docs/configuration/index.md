# Configuration

Domain Path's behaviour is controlled by one settings form and the per‑entity alias
fields it adds. The settings form is at **Configuration → Domain → Domain Path**
(`/admin/config/domain/domain_path`), and you need the **Administer domain paths**
permission (`administer domain paths`). It requires the Domain module and at least
one domain to be useful.

## Settings form, field by field

- **Entity types** — which content entity types get per‑domain alias fields. Only
  **Node** is enabled by default; add taxonomy terms, users, or other types here to
  give them domain aliases too. Enabling a type makes the *Domain‑specific aliases*
  widget appear on that type's edit form; disabling it removes those fields.
- **Alias title** — how each domain is labelled in the alias widget. Choose the
  domain's **name**, its **hostname**, or its full **URL**. The default is the
  domain name.
- **Hide path alias UI** — when on (the default), core's standard *URL alias* field
  is hidden on the entity form, so editors aren't confused by having both a global
  alias and per‑domain aliases. Turn it off if you still want the core field
  available.
- **Use advanced group** — when on (the default), the domain‑path widget is tucked
  into the advanced vertical‑tab sidebar of the edit form. Turn it off to show the
  fields inline in the main form instead.
- **Language method** — which language is used when resolving which alias to show:
  the **content** language of the entity (default), the **interface** language, or
  the **URL** language.

Click **Save configuration** to apply.

## Setting aliases on content

Once an entity type is enabled, open any entity of that type for editing. In the
*Domain‑specific aliases* section (in the advanced sidebar by default) you'll see
one alias field per domain. Type an alias (starting with `/`) for the domains you
want a custom URL on, and leave the rest blank to fall back to the entity's default
alias. Each domain's alias must be unique within that domain — but two different
domains may reuse the same alias string.

## How it behaves with the rest of Domain

- **Domain Access** — editors only see and set aliases for domains they are assigned
  to, and on save aliases are only written for domains the entity actually belongs
  to. Users with core's *administer url aliases* permission see every domain.
- **Domain Source** — when it sets the target domain for a link, Domain Path
  resolves that domain's specific alias, so cross‑domain links point at the right
  URL.
- **Pathauto** — install the Domain Path Pathauto submodule (see
  [Installation](../installation/index.md)) for automatic per‑domain aliases.
