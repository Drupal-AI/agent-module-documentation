<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# datetime_more — agent orientation

Adds a `datelist_more` datetime form element/widget: years 1-9999 + seconds, parts rendered as numeric inputs. Depends on core field/datetime.

- Element: `src/Element/DatelistMore.php` (extends core `Datelist`); registered via `hook_element_info`.
- No routes/perms/DB/external calls — no security surface. Pure widget.
