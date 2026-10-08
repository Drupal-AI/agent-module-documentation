Metatag Async Widget adds an alternative field widget for Metatag fields that defers loading the large meta-tags form until the editor clicks "Customize meta tags", making entity edit forms noticeably faster to render.

---

The module provides one field widget plugin, `metatag_async_widget_firehose` ("Advanced meta tags form (async)"), for the `metatag` field type. `AsyncMetatagFirehose` extends core Metatag's `MetatagFirehose` widget but, instead of building the full (very large) meta-tags element tree on every form render, it initially shows only a **"Customize meta tags"** button. Clicking it triggers an AJAX submit (`customizeMetaTagsSubmit` sets a form-state flag and rebuilds) that then renders the real Metatag firehose form in place. Until the editor opts in, the widget writes nothing new: `massageFormValues()` / `extractFormValues()` detect the untouched state and preserve the entity's existing meta-tag values (looking them up from the stored entity/revision/translation), so saving without expanding the form leaves current tags intact. It inherits the parent widget's `sidebar` setting (schema `field.widget.settings.metatag_async_widget_firehose` extends `field.widget.settings.metatag_firehose`), which puts the form in the node "advanced" sidebar group. It has no settings form, permissions, Drush or config of its own - you enable it by setting a metatag field's widget on the entity's *Manage form display*. The win is performance: heavy metatag fields no longer bloat every entity form; the form is only built for editors who actually edit SEO tags.

---

- Speed up node edit forms that carry a heavy Metatag field by loading it on demand.
- Show a lightweight "Customize meta tags" button instead of the full firehose form.
- Let editors expand the meta-tags form via AJAX only when they need it.
- Preserve existing meta tags when an editor saves without touching them.
- Swap the default Metatag widget for the async one on a content type's form display.
- Reduce render time on forms with many fields plus SEO meta tags.
- Keep the meta-tags form in the node "advanced" sidebar via the sidebar setting.
- Improve editor experience on entities where meta tags are rarely changed.
- Apply the async widget per bundle / per form mode independently.
- Use it on any entity type with a metatag field (nodes, terms, media, custom entities).
- Avoid building hundreds of meta-tag elements for editors who won't edit them.
- Lower memory/CPU on large multilingual edit forms with per-language meta tags.
- Configure it purely through Manage form display (no code required).
- Combine with Metatag defaults so unexpanded saves keep inheriting defaults.
- Give a cleaner initial edit form while still allowing full meta-tag control.
- Deploy via exported form-display config (`type: metatag_async_widget_firehose`).
- Keep revision/translation-correct meta-tag values when not customizing.
- Turn the sidebar placement on or off per field via the widget settings.
- Offer the async widget as the standard for all SEO-managed content types.
- Reduce time-to-interactive on editor-heavy admin forms.
- Migrate existing metatag fields to the async widget without changing stored data.
- Provide a performance-friendly SEO editing UX on a busy editorial site.
