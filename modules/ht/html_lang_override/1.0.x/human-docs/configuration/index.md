# Configuration

HTML Lang Override resolves the `<html lang>` value in a clear priority order: a
**per‑node** setting wins first, then a **per‑path** mapping, and finally the
**global default**. You can use as many or as few of these levels as you need.

## Grant the permissions

On **People → Permissions** (`/admin/people/permissions`):

- **Override HTML lang attribute** — lets a user open the settings form and set the
  per‑node language field. Grant it to the roles that manage page language.
- **Administer HTML lang override settings** — additionally required to change the
  global override toggle and the default language code.

## The settings form

Go to **Configuration → Regional and language → HTML Lang Override**, or navigate
directly to `/admin/config/regional/html-lang-override`.

### Global override

- **Override the default HTML lang attribute globally** — a toggle. When on, the
  **Default Language Code** you set here is used site‑wide wherever no per‑node or
  per‑path override matches. When off, the site's default language is used as the
  fallback.
- **Default Language Code** — the code applied by the global override (for example
  `en`, `ja`, `pt-br`). Use valid BCP‑47 language codes.

### Per‑path overrides

- **Path mappings** — a newline‑separated list of `path|langcode` entries. Each line
  maps an exact request path to a language code, so a specific page, view, or custom
  route can declare its own content language. For example:

  ```
  /about-us/francais|fr
  /news/japan-launch|ja
  ```

Save the form when you're done.

## Per‑node language

When editing a node, users with the **Override HTML lang attribute** permission see
a **Custom HTML Lang Attribute** field in the *Advanced* section of the edit form.
Enter a language code there to set the `<html lang>` value for just that node.
Clearing the field removes the override (and deleting the node cleans up its stored
value automatically). A per‑node value takes precedence over both path and global
settings.

## How it's applied (and good to know)

The module rewrites the `lang` attribute on the `<html>` element of the response as
it's sent, using the resolved code. A few practical notes:

- Language codes are **escaped and capped at 10 characters** before being stored and
  output, so the field is safe — but stick to valid codes for correct results.
- The override runs on **every HTML response**, which carries a very small
  performance cost on especially large pages. In normal use it's negligible.
