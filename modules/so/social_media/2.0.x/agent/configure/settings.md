<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure social_media

Everything is stored in the single config object **`social_media.settings`** under a
top-level `social_media` mapping keyed by network. Admin form:
`/admin/config/services/social-media` (route `social_media.admin_form`, permission
`administer site configuration`). The share links only appear once you place the
**"Social Sharing block"** (`social_sharing_block`) in a region, or add the
`social_media` field to an entity.

## Config shape

```yaml
# social_media.settings
social_media:
  <network>:            # facebook_share, facebook_msg, linkedin, twitter,
                        # pinterest, whatsapp, email, print
    enable: 1           # int 0/1 — include this network
    text: "Facebook"    # link label
    api_url: "https://www.facebook.com/share.php?u=[current-page:url]&title=[current-page:title]"
    api_event: "href"   # "href" = normal link; "onclick" = JS (e.g. window.print())
    default_img: 1      # int 0/1 — use bundled icon icons/<network>.svg
    weight: 1           # int — sort order (ascending)
    attributes: "target|_blank\nclass|facebook-share\nrel|noopener noreferrer"
    # optional:
    img: ""             # path to a custom icon (used when default_img is 0)
    library: "social_media/facebook"   # extra asset library to attach
    drupalSettings: "application_id|Your Application ID"  # pipe pairs -> drupalSettings.social_media
```

- **`api_url`** is passed through Token replacement at render time. Use
  `[current-page:url]` / `[current-page:title]` so each link shares the page the block
  is on. (Token module is a dependency.)
- **`api_event`** becomes the HTML attribute the URL is placed in: `href` produces an
  `<a href>`; `onclick` places JS in an `onclick` (used by `print` → `window.print()`
  and `facebook_msg` → `FB.ui(...)`).
- **`attributes`** and **`drupalSettings`** are multi-line, pipe-delimited
  `key|value` strings (one pair per line), parsed by the block.
- A network is only rendered when `enable == 1` **and** `api_url` is non-empty.

## Networks shipped by default

`facebook_share`, `facebook_msg`, `linkedin`, `twitter`, `pinterest`, `email` are
enabled by default; `whatsapp` and `print` ship with `enable: 0`. Icons live in
`icons/<network>.svg`.

## Email "forward this page" mode

The `email` item supports two extra integer keys (see `config/schema`):

- `enable_forward: 1` — replace the `mailto:` link with an in-site form at
  `/social-media-forward` (route `social_media.forward`, controller-guarded access).
  The block appends `&destination=<current path>`.
- `show_forward: 1` — open that form in an AJAX modal dialog
  (`core/drupal.dialog.ajax`).

## Drush / config recipes

Read the whole object, or one network:

```bash
drush cget social_media.settings social_media
drush cget social_media.settings social_media.whatsapp
```

Enable WhatsApp and give it a label (whatsapp is disabled by default):

```bash
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("social_media.settings");
  $m = $c->get("social_media");
  $m["whatsapp"]["enable"] = 1;
  $m["whatsapp"]["text"] = "WhatsApp";
  $c->set("social_media", $m)->save();
'
drush cr
```

Set a network's share endpoint and event:

```bash
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("social_media.settings");
  $m = $c->get("social_media");
  $m["twitter"]["api_url"] = "https://twitter.com/intent/tweet?url=[current-page:url]";
  $m["twitter"]["api_event"] = "href";
  $c->set("social_media", $m)->save();
'
drush cr
```

> Note: the top-level key is `social_media` **inside** `social_media.settings`, so the
> full path to WhatsApp's enable flag is `social_media.settings:social_media.whatsapp.enable`.
> Always read-modify-write the whole `social_media` array (as above) to avoid dropping
> sibling networks.

## Place the block

```bash
drush php:eval '
  \Drupal\block\Entity\Block::create([
    "id" => "socialsharing",
    "plugin" => "social_sharing_block",
    "region" => "content",
    "theme" => \Drupal::config("system.theme")->get("default"),
    "settings" => ["label" => "Share this", "label_display" => "visible"],
  ])->save();
'
```

The block caches per URL path (`url.path` context + a `social_media:<path>` cache tag
and `config:social_media.settings`), so links update as visitors navigate.
