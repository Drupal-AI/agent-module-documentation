<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Trufil — widget plugins

Trufil exposes three plugin types, each with an annotation and base class, discovered by a dedicated manager.

| Type | Annotation | Manager service | Directory |
|---|---|---|---|
| Filter | `@TrufilFilterWidget` | `plugin.manager.trufil_filter_widget` | `src/Plugin/trufil/filter/` |
| Sort | `@TrufilSortWidget` | `plugin.manager.trufil_sort_widget` | `src/Plugin/trufil/sort/` |
| Pager | `@TrufilPagerWidget` | `plugin.manager.trufil_pager_widget` | `src/Plugin/trufil/pager/` |

## Built-in filter widgets
`DefaultWidget`, `Autocomplete` (text/radios/select), `Links`, `Lists`, `DatePickers`, `Number`, `Single` (on/off checkbox), `Hidden`.

## Built-in sort/pager widgets
Sort: `DefaultWidget`, `RadioButtons`, `Links`. Pager: `DefaultWidget`, `RadioButtons`, `Links`.

## Enabling
On a View → Exposed form → **Format** choose **Trufil**. The plugin's settings form then renders a per-filter widget selector plus general options: `autosubmit`, `autosubmit_textfield_delay`, `autosubmit_exclude_textfield`, `autosubmit_hide`, `allow_secondary` + `secondary_label`/`secondary_open`, `reset_button_always_show`, `input_required`.

## Creating a widget
Extend the matching base (`FilterWidgetBase` / `SortWidgetBase` / `PagerWidgetBase`), add the annotation, implement the configuration + build methods. It is auto-discovered by the manager.

## Altering options
Implement `hook_trufil_options_alter(array &$options, ViewExecutable $view, $display)` to mutate resolved Trufil options before the exposed form is built.
