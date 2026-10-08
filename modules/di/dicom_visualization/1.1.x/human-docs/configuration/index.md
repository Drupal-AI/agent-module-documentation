# Configuration

Getting DICOM images to display takes a few steps: allow `.dcm` files on a File
field, switch that field's formatter to a DICOM viewer, adjust the per-field
display options, and (optionally) tune the global settings that apply to every
viewer.

## 1. Allow .dcm uploads on a File field

1. Go to **Structure → Content types → [your content type] → Manage fields**.
2. Add a **File** field, or edit an existing one.
3. In the field settings, add **`dcm`** to the **Allowed file extensions** list so
   the site recognizes medical imaging files.
4. Save.

## 2. Set the DICOM formatter

1. On the same content type, open the **Manage display** tab.
2. Find your File field and change its **Format** to one of:
   - **DICOM File Formatter** — standard viewing.
   - **DICOM Advanced File Formatter** — enhanced, interactive controls.
3. Save.

## 3. Adjust per-field display settings

Still on **Manage display**, click the gear icon (⚙) next to the field to open its
formatter settings. Here you can:

- Choose the **UI theme** for the viewer (from the 15+ bundled medical themes).
- Decide **how multiple DICOM files stack** — a vertical stack, a scrollable
  gallery, or individual standalone viewers.

Save the formatter settings, then save the display.

## 4. Global settings

For settings that apply across all viewers, go to **`/admin/dicom-configuration`**.
This page controls:

- **Tag mappings** — which DICOM metadata tags are shown (Patient ID, Modality,
  Study Date, and dozens more).
- **Quadrant placement** — which viewport corner (Top-Left, Top-Right,
  Bottom-Left, Bottom-Right) each mapped tag appears in.
- **Overlay text colors** — the color of the metadata text drawn over the image.

Save your changes.

## Data-handling reminder

DICOM metadata can contain patient identifiers (PHI). Keep the File field on a
**private file scheme** with appropriate access control, be mindful of which tags
you surface in the overlays, and handle everything in line with HIPAA/GDPR and
your organization's healthcare data policy. The module relies on Drupal's own file
and entity access — it adds no access control of its own.
