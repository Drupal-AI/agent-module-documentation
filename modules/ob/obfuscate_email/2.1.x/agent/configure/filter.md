<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Text-format filter: `obfuscate_email`

Class `src/Plugin/Filter/ObfuscateEmail.php`. There is **no admin settings page** for the module
(`configure` = null); the only configuration lives inside a text format's filter settings.

## Enable it

At Administration » Configuration » Content authoring » Text formats and editors, edit a format
(e.g. *Full HTML*) and enable **Obfuscate Email** under *Enabled filters*. In config this is
`filter.format.<id>` → `filters.obfuscate_email.status: true`.

- Filter id: `obfuscate_email`, provider `obfuscate_email`.
- Type: `Drupal\filter\Plugin\FilterInterface::TYPE_TRANSFORM_REVERSIBLE` — it only rewrites markup
  at render time and composes safely with other filters.

## Settings

| Setting | Key | Default | Effect |
|---|---|---|---|
| Force user to click link to display mail address | `click` | `FALSE` | If on, the address is revealed only after the visitor clicks the link. |
| Text to show on link | `click_label` | "Click here to show mail address" | The link text shown before reveal (only relevant when `click` is on; the field is `#states`-hidden otherwise). |

Config schema: `filter_settings.obfuscate_email` (`config/schema/obfuscate_email.schema.yml`).

## What the filter does to the text

`process($text, $langcode)`:
1. Returns unchanged if the text contains no `mailto`.
2. Loads the HTML and finds every `<a href="mailto:…">`.
3. For each, ROT13-encodes the address after replacing `.`→`/dot/` and `@`→`/at/`, and stores it
   in `data-mail-to`.
4. Replaces the visible address in the link text with `@email` and sets `data-replace-inner="@email"`.
5. If `click` is on, sets `data-mail-click-link` and replaces the link text with `click_label`.
6. Sets the anchor `href="#"`.

The scrambled markup is decoded and restored in the browser — see
[theming/email-field.md](../theming/email-field.md) for the JS behaviour (shared by both entry points).

## Scripted setup

```php
use Drupal\filter\Entity\FilterFormat;
$format = FilterFormat::load('full_html');
$format->setFilterConfig('obfuscate_email', [
  'status' => TRUE,
  'settings' => ['click' => TRUE, 'click_label' => 'Reveal email'],
])->save();
```
