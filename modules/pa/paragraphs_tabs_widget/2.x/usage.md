Paragraphs Tabs Widget provides a field widget that renders each item of a multi-value Paragraphs field as a Drupal core vertical tab in the entity edit form.

---

Paragraphs Tabs Widget replaces the default stacked "Inline paragraphs" editing form with a vertical-tabs interface: every referenced paragraph becomes its own tab, so editors click between paragraphs instead of scrolling one long form. It ships a single field widget (`paragraphs_tabs_widget_vertical_tabs`) that extends the Paragraphs module's `InlineParagraphsWidget` and swaps the render output for Drupal core's `vertical_tabs` element, moving the "Add more" control into the tab menu and driving tab summaries from an optional jQuery selector. It applies to any `entity_reference_revisions` field (i.e. a Paragraphs field), is selected per form display under Manage form display, requires the Paragraphs module (>=1.3) and Drupal ^10.2 || ^11, and adds no display-side or storage changes — only how the edit form looks.

---

- Turn a long Paragraphs edit form into a tabbed interface.
- Show each paragraph item as its own vertical tab.
- Reduce scrolling when a field holds many paragraphs.
- Let editors jump directly to a specific paragraph.
- Apply the "Vertical tabs" widget to an `entity_reference_revisions` (Paragraphs) field.
- Select the widget per bundle under Structure → Content types → Manage form display.
- Keep the paragraph type title in the tab label instead of repeating it in the form.
- Move the "Add more" button into the tab menu so new tabs appear inline.
- Set a per-tab summary from a field value using the "Tab summary selector" setting.
- Configure the tab title label via the inherited Paragraphs "Title" setting.
- Use the inherited "Add mode" (select list, buttons, dropdown) to add paragraphs.
- Pick which paragraph form display mode each tab uses.
- Set a default paragraph type for new tabs.
- Restrict who may edit the summary-selector setting with the module's permission.
- Give paragraph-heavy landing pages a cleaner authoring experience.
- Improve editorial UX for complex component-based content.
- Combine with any paragraph types you already have — no new paragraph types required.
- Keep the same stored data and front-end display as the default widget.
- Adopt on Drupal 10.2+/11 sites already using Paragraphs 1.3+.
- Configure the widget entirely through configuration (exportable form-display config).
- Swap back to the stock Paragraphs widget at any time from Manage form display.
