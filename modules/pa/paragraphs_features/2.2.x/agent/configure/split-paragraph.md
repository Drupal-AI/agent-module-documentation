# CKEditor 5 "Split paragraph" tool

The module ships a CKEditor 5 plugin (`paragraphs_features.ckeditor5.yml` →
`paragraphs_features_split_paragraph`, JS plugin `split_paragraph.SplitParagraph`) that adds
a **Split paragraph** toolbar button. In a paragraphs-based rich-text field it lets an editor
split the current text into two separate paragraph entities at the cursor.

## Enable it
1. Go to **Admin → Config → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a CKEditor 5-based format used inside a
   Paragraphs text field.
2. Drag the **Split paragraph** button from *Available buttons* into the *Active toolbar*.
3. Save. (Toolbar item id: `splitParagraph`; `elements: false` — it adds no new HTML tags,
   so no allowed-tags change is needed.)

The button coordinates with the Paragraphs widget's remove/add machinery (the widget's
remove button is tagged with `data-paragraphs-split-text-type` in
`hook_paragraphs_widget_actions_alter()`), and uses the `paragraphs_features/splitParagraph`
library. No configuration beyond adding it to the toolbar.
