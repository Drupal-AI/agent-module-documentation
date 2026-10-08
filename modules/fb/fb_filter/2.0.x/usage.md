<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Facebook Filter is a text-format filter that turns Facebook #hashtags in content into links to facebook.com/hashtag pages.

---

Facebook Filter provides one Filter plugin (id `fb_filter`, title "Facebook filter") in the Other package, depending only on core's Filter system. When enabled on a text format, its `process()` runs a single Unicode regular expression over the text and rewrites every `#hashtag` (a `#` at the start of the text or after whitespace, followed by word/letter characters) into an `<a class="facebook-hashtag" href="https://www.facebook.com/hashtag/<tag>">#<tag></a>` link. One setting, `link_hashtags_target`, chooses whether those links open in a new tab (`_blank`) or the same tab (`none`, the default). The filter is `TYPE_TRANSFORM_IRREVERSIBLE`, so it changes the rendered output only — the stored source text is untouched — and it takes effect wherever content in that text format is displayed. It has no settings page of its own (configuration is per text format), no routes, no permissions, no services and no Drush commands.

---

- Automatically turn Facebook-style #hashtags in body text into clickable links.
- Point every #hashtag at its Facebook hashtag page (`facebook.com/hashtag/<tag>`).
- Give hashtag links a stable CSS hook (`class="facebook-hashtag"`) for theming.
- Let editors write #hashtags in plain content and have them linked on display.
- Choose whether hashtag links open in a new browser tab (`_blank`) or the same tab.
- Enable hashtag linking on a specific text format (for example a "Social post" format).
- Keep the stored content unchanged while linking hashtags only at render time.
- Add social-style hashtag linking without writing any custom filter code.
- Support Unicode/accented hashtags via the filter's `\p{L}`/`\p{M}` regex.
- Present the "Facebook #hashtags turn into links automatically" tip on the format's editing help.
- Combine with core's "Limit allowed HTML tags" filter in the same format (order it after that filter so the anchors survive).
- Use on nodes, comments, blocks or any field rendered through a text format that has the filter enabled.
- Provide consistent hashtag markup across a site for analytics or styling.
- Drive campaign/landing content where hashtags should deep-link to Facebook.
- Apply hashtag linking to migrated or imported social content on output.
- Restrict hashtag linking to trusted editorial formats only, by enabling the filter per format.
- Disable the filter on a format to instantly stop linking hashtags without editing content.
- Theme the resulting links (color, icon, hover) purely via the `.facebook-hashtag` class.
- Pair with a text format's help/tips so authors know hashtags are auto-linked.
- Roll hashtag linking out or back by toggling one checkbox in the text format configuration.
