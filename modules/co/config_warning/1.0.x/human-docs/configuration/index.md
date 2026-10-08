# Configuration

Config Warning's behaviour is set from a single form. The warning is **off by
default**, so nothing appears until you enable it here.

## Open the settings form

1. Log in as a user with the **Administer site configuration** (`administer site
   configuration`) permission.
2. Go to **Configuration → Development → Config warning**, or navigate directly to
   `/admin/config/development/config-warning`.

## Fields

- **Enable warning message** — the master on/off switch. Leave it off while you are
  actively developing and turn it on for production, so editors only see the warning
  where it matters.
- **Warning message** — the text shown as a Drupal warning on config-altering admin
  forms. It is translatable, so you can provide the message per language. Use it to
  state your team's policy — for example, "Changes made here may be overwritten on the
  next deployment; please make configuration changes in code."
- **Page path conditions** — controls *where* the warning appears, using Drupal's
  standard request-path condition:
  - **Paths** — one path per line; wildcards are allowed (for example
    `/admin/structure/block/*`).
  - **Exclude matching paths** — checked by default. When **checked**, the warning is
    *hidden* on the listed paths (it shows everywhere else it qualifies). When
    **unchecked**, the warning shows *only* on the listed paths. Leaving the paths
    empty with the default (exclude) setting means the warning can appear on any
    qualifying admin form.

## How the warning is decided

Behind the scenes, on admin routes only, the module evaluates your path conditions
and — if the warning is enabled — flags the form as config-altering when the form
either is a settings form (declares `getEditableConfigNames()`), is an entity form
editing an existing config entity, is core's user-permissions form, or is the block
listing form. When flagged, your message is added via the messenger.

## Save

Click **Save configuration**. The change takes effect immediately — open a
qualifying admin form to confirm the warning shows (or is correctly hidden) where you
intended.
