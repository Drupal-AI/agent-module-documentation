<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Spamicide protection

## The `spamicide` config entity

One entity per protected form. Config schema `spamicide.spamicide.*`:

| Key | Meaning |
|---|---|
| `id` / `uuid` | Entity identifiers. |
| `label` | Human label. |
| `description` | Optional note. |
| `spamicide_form_id` | The Drupal `$form_id` this protection applies to. |
| `status` | Enabled flag (only enabled entities protect a form). |

Manage at `admin/structure/spamicide`:

| Route | Path | Access |
|---|---|---|
| `entity.spamicide.collection` | `/admin/structure/spamicide` | `administer spamicide` |
| `entity.spamicide.add_form` | `/admin/structure/spamicide/add` | `administer spamicide` |
| `entity.spamicide.edit_form` | `/admin/structure/spamicide/{spamicide}` | `administer spamicide` |
| `entity.spamicide.delete_form` | `…/{spamicide}/delete` | `administer spamicide` |
| `spamicide.spamicide_settings` | `/admin/structure/spamicide/settings` | `administer site configuration` |

## How a form gets protected (`spamicide.module`)

`spamicide_form_alter()`:
1. Loads an enabled `spamicide` entity whose `spamicide_form_id` == current `$form_id`.
2. If found, adds a `feed_me` textfield (`#weight 999`, class `feed_me_textfield`), pushes actions
   below it, attaches library `spamicide/spamicide`, and appends `spamicide_validate` to `#validate`.
3. The library's CSS (`css/…`) hides `.form-item-feed-me` (`visibility:hidden; height:0`), so humans
   never see or fill the field; bots that auto-fill inputs do.

`spamicide_validate()`:
- If `feed_me` is empty → pass (do nothing).
- If filled → `setError()` on the form; if `spamicide_log_attempts`, log form id + client IP to the
  `spamicide` channel and increment `spamicide_counter`; then send a `RedirectResponse` to the current
  route (the front page in the login case).

## Settings (`spamicide.settings`)

| Key | Default | Meaning |
|---|---|---|
| `spamicide_admin_mode` | `TRUE` | Show an "Add spamicide to this form" link on unprotected forms, for users with `administer spamicide` (excludes spamicide's own forms, search forms, and `/admin/structure` paths). |
| `spamicide_log_attempts` | `TRUE` | Log blocked attempts (with IP) to watchdog and bump the counter. |
| `spamicide_counter` | `0` | Running total of blocked submissions. |

## Defaults & notes

- `spamicide_install()` seeds protections for the five core forms listed in `start.md`.
- The honeypot field name is **fixed** as `feed_me` in this release (the README mentions renaming it,
  but the current code hardcodes `feed_me` / `feed_me_textfield`).
- This is honeypot-only; it does not add flood control, CAPTCHA, or timing checks. Layer with
  Honeypot/CAPTCHA if you need more.

```bash
# Protect a custom form by id
ddev drush php:eval "\Drupal::entityTypeManager()->getStorage('spamicide')->create(['id'=>'my_form','label'=>'My form','spamicide_form_id'=>'my_custom_form','status'=>TRUE])->save();"
```
