# Configure Linkit profiles

![Linkit profiles list](../../../../../../../screenshots/linkit/7.0.x/profiles.png)

Profiles are config entities (`linkit.linkit_profile.*`). A default profile ships in
`config/optional/linkit.linkit_profile.default.yml`.

## Manage (UI + routes)
- List / add / edit / delete profiles: `/admin/config/content/linkit`
  (`entity.linkit_profile.collection`, `.add_form`, `.edit_form`, `.delete_form`).
- A profile = `label`, `id`, `description`, and an ordered `matchers` sequence.
- Manage matchers on a profile: `/admin/config/content/linkit/manage/{profile}/matchers`
  (routes `linkit.matchers`, `linkit.matcher.add|edit|delete`). Matcher order = suggestion order.

## Attach to an editor
1. `/admin/config/content/formats` → edit a text format that uses CKEditor 5.
2. Enable the **Drupal link** plugin, then in its settings toggle Linkit on and pick a profile
   (stored under `editor.settings.plugins.drupallink.linkit_enabled` / `linkit_profile`).
3. Enable the **Linkit** filter on the same format. It must run **before** "Limit allowed HTML".
4. If "Limit allowed HTML" is on, add `data-entity-type data-entity-uuid` (and `title` for
   automatic titles) to the allowed `<a>` tag.

## Matcher config (schema `linkit.matcher.entity`)
Entity matchers support: `metadata` (token-enabled suggestion text), `bundles` (limit to
selected bundles), plus per-plugin settings like result limit, include unpublished, and
substitution type. Suggestions insert `entity:{type}/{id}`; the filter resolves it at render.
