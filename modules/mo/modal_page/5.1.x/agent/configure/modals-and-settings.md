# Modals & global settings

Two kinds of config: **modal** config entities (one per dialog) and the single
**`modal_page.settings`** object (global behavior).

## Admin routes

| Route | Path | Purpose |
|---|---|---|
| `entity.modal.collection` | `/admin/structure/modal` | List modals (also `modal_page.default`) |
| `entity.modal.add_form` | `/admin/structure/modal/add` | Add a modal |
| `entity.modal.edit_form` | `/admin/structure/modal/{modal}` | Edit |
| `modal_page.settings` | `/admin/config/user-interface/modal-page/settings` | Global settings (the `configure` route) |
| `modal_page.help` | `/admin/modal/help` | Help |

All require the **`administer modal page`** permission.

## The `modal` config entity

- Entity type id **`modal`**; config prefix `modal` → config name **`modal_page.modal.<id>`**.
- Class `Drupal\modal_page\Entity\Modal` (`ConfigEntityBase`), forms `ModalForm` /
  `ModalDeleteForm`, list builder `ModalListBuilder`.

Notable fields (entity keys / `config_export`):

| Key | Meaning |
|---|---|
| `label` | Modal title |
| `body` | Formatted text (`{ value, format }`); sanitized to `allowed_tags` |
| `pages` | Path(s) to show on; supports wildcards (`/blog/*`) and `<front>` |
| `type` | `page` (match by path) or `parameter` |
| `roles` | Sequence of role ids allowed to see it |
| `languages_to_show` | Sequence of langcodes |
| `auto_open` | Open automatically on load |
| `open_modal_on_element_click` | CSS selector that opens the modal on click |
| `modal_size` | `modal-sm` / `modal-md` / `modal-lg` |
| `modal_video_link` | Embedded video URL |
| `enable_right_button` / `ok_label_button` | OK button + label |
| `enable_left_button` / `left_label_button` | Dismiss button + label |
| `display_button_x_close` / `top_right_button_label` | Top-right X close |
| `enable_dont_show_again_option` / `dont_show_again_label` | "Don't show again" |
| `enable_custom_cookie_expiration` / `custom_cookie_expiration_time` | Cookie lifetime |
| `close_modal_esc_key` / `close_modal_clicking_outside` | Close behaviors |
| `enable_redirect_link` / `redirect_link` | Redirect on accept |
| `modal_page_auto_hide` / `modal_page_auto_hide_delay` | Auto-hide after delay |
| `modal_page_show_once` | Show only once |
| `enable_show_on_height` / `height_offset` / `height_offset_touch` | Show after scroll offset |
| `enable_modal_header` / `enable_modal_footer` / `display_title` | Header/footer/title toggles |
| `modal_class` / `header_class` / `footer_class` / `*_button_class` | Custom CSS classes |
| `published` | Whether active |
| `publish_on` / `unpublish_on` | Scheduling timestamps (see drush/commands.md) |

### Create a modal programmatically

```php
\Drupal\modal_page\Entity\Modal::create([
  'id' => 'welcome',
  'label' => 'Welcome',
  'body' => ['value' => '<p>Hello!</p>', 'format' => 'basic_html'],
  'pages' => '<front>',
  'type' => 'page',
  'auto_open' => TRUE,
  'published' => TRUE,
  'roles' => [],
])->save();
```

Read one: `drush config:get modal_page.modal.welcome`.
List all: `drush config:status` or load via the `modal` storage.

## Global settings — `modal_page.settings`

Config object (schema `modal_page.settings`), shipped defaults
(`config/install/modal_page.settings.yml`):

| Key | Default | Meaning |
|---|---|---|
| `verify_load_bootstrap_automatically` | `true` | Check if Bootstrap needs auto-loading |
| `load_bootstrap` | `false` | Force-load Bootstrap from CDN |
| `bootstrap_version` | `'3x'` | `3x` or `5x` |
| `allowed_tags` | `h1,h2,a,b,big,...` | HTML tags allowed in modal bodies |
| `clear_caches_on_modal_save` | `false` | Rebuild caches when a modal is saved |
| `default_cookie_expiration` | `10000` | Default "don't show again" cookie lifetime |

```bash
drush config:get modal_page.settings
drush config:set modal_page.settings bootstrap_version 5x -y
```

Front-end selection is done by `ModalPageService` (`modal_page.modals`): `getModalsToShow()`
filters by current path, role and language. Bootstrap/JS come from `modal_page.libraries.yml`.
