# Configure — settings + report block

## Settings form

Route `dubbot.settings` → `/admin/config/content/dubbot/settings` (permission
`administer dubbot configuration`). Writes the `dubbot.settings` config object:

| Key | Form field | Default | Notes |
|---|---|---|---|
| `embed_key` | Embed key (textfield) | `''` | Generated in your DubBot account. On save the form calls `Client::isValidEmbedKey()` (a live API GET) and rejects an invalid key. |
| `api_url` | Dubbot API URL (textfield) | `https://api.dubbot.com` | Base URL for report/highlight calls; override only if DubBot gives you a different endpoint. |
| `dialog_renderer` | DubBot Report position (radios) | `off_canvas` | `0` = Modal, `off_canvas` = Side tray, `off_canvas_top` = Top panel. |
| `preview_selector` | Preview Selector (textfield) | `#page` | CSS selector wrapping the page preview; change if issue highlighting doesn't line up on your theme. |

Set without the UI (bypasses the live key validation the form does):

```bash
drush cset dubbot.settings dialog_renderer off_canvas_top -y
drush cset dubbot.settings preview_selector '.region-content' -y
drush cset dubbot.settings api_url 'https://api.dubbot.com' -y
```

Because saving via the form validates the key against DubBot's API, seeding a key in automation
is usually done with `drush cset dubbot.settings embed_key <key>` (no validation) — but reports
only render if the key is genuinely valid for the site's domain.

## Overview page

`dubbot.overview` → `/admin/config/content/dubbot` (permission `access dubbot report`) lists
crawled pages with issue counts and links to per-page reports (`dubbot.report`), which open in
the position chosen by `dialog_renderer`.

## DubBot Report block (`dubbot_report`)

A Block plugin (id `dubbot_report`, category *DubBot*) that shows the current page's report
inline. Place it like any block — via *Block layout* or a `block` config entity:

```php
\Drupal\block\Entity\Block::create([
  'id' => 'dubbot_report_demo',
  'plugin' => 'dubbot_report',
  'theme' => 'olivero',
  'region' => 'content',
  'settings' => [
    'id' => 'dubbot_report',
    'label' => 'DubBot Report',
    'label_display' => '0',
    'link_color' => '#1b9ae4',   // block setting; default #1b9ae4
  ],
  'visibility' => [],
])->save();
```

The only block-specific setting is `link_color` (a 7-char hex, default `#1b9ae4`). The block
renders nothing useful unless a report exists for the current page and the user has report
access.
