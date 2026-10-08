# Configuration

All of this module's behavior is driven by one short settings form: a checklist of
paragraph types whose **Duplicate** control should be hidden. Until you tick at
least one type and save, the module does nothing — every component keeps its
Duplicate button.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content → Layout Paragraphs settings** and open the
   **Disable Duplicate** tab, or navigate directly to
   `/admin/config/content/layout_paragraphs/disable-duplicate`.

## Choose which types lose the Duplicate control

The form lists every paragraph type on your site as a checkbox. Tick the types
whose Duplicate control you want to remove:

- Ticking a type hides its Duplicate button in the Layout Paragraphs builder (and
  in any editor built on Layout Paragraphs, such as Mercury Editor).
- Leaving a type unticked keeps its Duplicate button exactly as before.

Common choices are singleton components (a hero or banner that should appear only
once), wrapper/section paragraph types, complex components that are error‑prone
when copied, and any type carrying a unique HTML ID or anchor.

## Save

Click **Save configuration**. The change takes effect immediately: open a page in
the Layout Paragraphs builder and the components of the types you selected will no
longer show a **Duplicate** button. Their **Edit**, **Delete**, drag‑to‑reorder,
and add‑new controls are untouched, and editors can still add brand‑new components
of the same type — they simply cannot duplicate an existing one.

To re‑enable duplication later, return to this form, clear the relevant checkboxes,
and save again.
