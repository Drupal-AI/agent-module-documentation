<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Inline Ad Entity formatter

Prerequisite: the `ad_entity` module is installed and at least one **Ad display** (`ad_display` entity) is configured.

1. Go to the entity's **Manage display** (e.g. `/admin/structure/types/manage/article/display`).
2. For a text field (`text`, `text_long`, or `text_with_summary`), set the **Format** to **Content with Inline Ads**.
3. Open the formatter settings (gear icon) and set:
   - **Ad Frequency** (`ad_frequency`) — insert an ad after every N `<p>` paragraphs (default `3`).
   - **Ad Display** (`ad_display`) — the `ad_display` entity to render inline.
4. Save the display.

Behavior: the field HTML is parsed (Masterminds HTML5), split on `<p>` boundaries, grouped every `ad_frequency` paragraphs, and the chosen ad display is rendered between groups. No ad is added after the final chunk. Empty chunks are skipped.

Config export (field formatter settings) shape:
```yaml
type: inline_ad_entity
settings:
  ad_frequency: 3
  ad_display: <ad_display_entity_id>
```
