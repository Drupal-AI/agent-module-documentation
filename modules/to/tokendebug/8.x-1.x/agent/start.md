<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Token Debug UI (tokendebug) — agent index

One admin form that resolves tokens against real entities you name, and shows the replaced text
plus optional cacheability metadata. Answers "what does this token evaluate to right now for this
entity?" — which core's token *browser* (list of what is available) does not. Version **8.x-1.1**,
core `^8.7.7 || ^9 || ^10 || ^11`. GPL-2.0-or-later.

## What it actually is
- A single form, no config entities, no schema, no services, no plugins, no drush commands.
- Class: `Drupal\tokendebug\Form\TokenDebugForm` (`FormBase`, form id `tokendebug_form`),
  file `src/Form/TokenDebugForm.php`.
- Route: `tokendebug.form` → path `/admin/config/development/tokendebug`
  (`tokendebug.routing.yml`); menu link under *Configuration › Development*
  (`tokendebug.links.menu.yml`); `configure:` target in the `.info.yml`.
- Permission: `tokendebug:use form` ("Use the token debug form", `tokendebug.permissions.yml`) —
  the only access gate. **Not** marked `restrict access: TRUE`.

## Mechanism (read the source, it is ~150 lines)
1. Inputs: **Text with tokens** textarea; **Token data** textarea (one `entity_type:id` per line,
   e.g. `node:17`); **Clear unknown tokens** checkbox; **Show metadata** checkbox; a
   `token_tree_link` browse element.
2. `parseData()` (`TokenDebugForm.php:116`) splits each line on the first `:`, then
   `entityTypeManager->getStorage($type)->load($id)`, keying the loaded entity by type into
   `$data`.
3. `submitForm()` calls core `\Drupal::service('token')->replace($text, $data, ['clear' => $clear],
   $metadata)` (`:88`) and prints the result via `Markup::create()`. Token service sanitizes
   replacement values by default.
4. With **Show metadata**, the bubbled `BubbleableMetadata` is `print_r`'d into a `<pre>` status
   message (cache tags/contexts/max-age).

## Dependencies
- `.info.yml` declares **no** module dependencies.
- Functionally needs the contrib **token** module: the `token_tree_link` theme (the browse link) is
  provided by token. Core `\Drupal\Core\Utility\Token` (the replace service) is core, not contrib.

## Deployment / review notes
- Development/debugging tool. Keep it out of the production module list, not merely unlinked from
  the menu. A debug tool left enabled in production is a recurring audit finding.
- The form resolves and prints the *actual* token values for the entities you name, so it is a
  data-disclosure surface if reachable by the wrong person. Treat `tokendebug:use form` as
  high-trust, admin-only. See `usage.md` for the field-by-field behaviour.
