<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

| Command | Alias | Action |
| --- | --- | --- |
| `drush llms-txt-gen:generate` | `llms-gen` | Delete existing sections, then regenerate one `llms_txt_section` per content type from published, anonymously-viewable nodes. |
| `drush llms-txt-gen:delete` | `llms-del` | Delete all generated `llms_txt_section` entities. |

Both delegate to the `llms_txt_gen.generator` service. Generation also runs on every cron run and once on module install.

```bash
drush llms-gen   # rebuild after a content import
drush llms-del   # clear all generated sections
```
