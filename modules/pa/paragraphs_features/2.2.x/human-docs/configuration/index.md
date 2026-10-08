# Configuration

Paragraphs Features has one small global setting and a set of features you switch
on per Paragraphs field. All of it is stored as ordinary Drupal configuration and
exports with `drush config:export`.

## Global setting

1. Go to **Configuration → Content authoring → Paragraphs features**
   (`/admin/config/content/paragraphs_features`). This form needs the **Administer
   site configuration** permission.
2. The single option is:
   - **Dropdown to button** (off by default) — when a paragraph's actions
     drop-down has only one visible action, render it as a plain one-click button
     instead of a menu. This saves editors a click across the whole site.

Save the form to apply it.

## Per-field widget features

The rest of the features are configured on each Paragraphs field's widget:

1. Go to **Structure → Content types → *(your type)* → Manage form display**.
2. Find the paragraphs field (it must use the **Paragraphs** widget), and click the
   **gear icon** at the end of its row.
3. Switch on the features you want for this field:
   - **Add in between** — show "+ Add" buttons between existing paragraphs so a new
     item can be inserted at an exact position.
   - **Number of add-in-between links** — how many paragraph-type quick links appear
     in that "+ Add" control.
   - **Delete confirmation** — require a confirmation step before an editor removes a
     paragraph, guarding against accidental loss on long lists.
   - **Show drag & drop** — expose Paragraphs' advanced drag-and-drop reorder UI
     (this uses core's `sortable` library).
   - **Show collapse all** — show or hide a collapse-all button on the field.
4. Click **Update**, then **Save** the form display.

Because these are set per widget, you can give different paragraph fields different
feature sets. They are stored in the form display's third-party settings and export
with the rest of your display configuration.

## CKEditor 5 "Split paragraph" tool

The Split paragraph button lets an editor split one text paragraph into two at the
cursor. Add it to the text format used inside your paragraphs:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a **CKEditor 5**-based format used in
   a Paragraphs text field.
2. Drag the **Split paragraph** button from *Available buttons* into the *Active
   toolbar*.
3. Save. It adds no new HTML tags, so there is no allowed-tags change to make and
   nothing else to configure.

Editors will now see the Split paragraph button in the toolbar; clicking it breaks
the current text into two separate paragraph items.
