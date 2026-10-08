<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

Obfuscate Email has no settings page of its own. There are two ways to switch it
on, described below.

## Option 1 — the text-format filter (for rich-text content)

Use this to scramble `mailto:` links inside body fields and other rich-text
content authored with a given text format.

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Click **Configure** next to the format you want to protect (for example *Full
   HTML*).
3. Under **Enabled filters**, tick **Obfuscate Email**.
4. Configure its two settings under the filter settings section:
   - **Force user to click link to display mail address** *(off by default)* —
     when off, the real address appears automatically as soon as the page loads.
     When on, the address stays hidden behind a link that the visitor must click
     to reveal — a bit more resistance against bots.
   - **Text to show on link** *(default: "Click here to show mail address")* —
     the wording of that reveal link. This only matters when the click option
     above is turned on.
5. Click **Save configuration**.

Any address written as a `mailto:` link in content using this format is now
scrambled in the page source and reassembled in the browser. The filter is
"transform-reversible", so it only rewrites markup at render time and composes
safely with the other filters on the format.

## Option 2 — the `field_email` field template (for email fields)

The module ships a template that automatically obfuscates any field whose machine
name is literally **`field_email`**. There is nothing to configure — once the
module is enabled, those fields are scrambled on output wherever they render
(node displays, Views field output, and so on).

- It works for both display styles: a linked email becomes an obfuscated anchor
  that turns into a real `mailto:` link client-side, and a plain-text email
  becomes an obfuscated `<span>` that reassembles on load.
- To customize the markup, copy `field--email.html.twig` from the module into your
  theme and edit it using Drupal's normal theme-suggestion system.

## Bonus: the `rot13` Twig filter

The module registers a `rot13` Twig filter you can use in any template to scramble
other strings, for example `{{ 'some string'|rot13 }}`.

## A reminder about JavaScript

Both paths rely on JavaScript to turn the scrambled text back into a usable
address. Visitors with JavaScript disabled will not see the email at all — this is
by design.
