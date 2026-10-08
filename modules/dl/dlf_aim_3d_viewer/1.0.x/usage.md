DLF AIM 3D Viewer renders interactive 3D models attached to a core file field, using the three.js-based DLF AIM 3D Viewer JavaScript library, and ships a server-side pipeline that converts and thumbnails many model formats to GLB.

---

The module targets sites that store 3D models (originally WissKI-based cultural-heritage repositories, but also standalone Drupal) and need to show them in the browser instead of offering a raw file download. You attach a **file field** to an entity bundle, set its display format to **"DLF AIM 3D Viewer"**, and the formatter emits a viewer container that the bundled JS library (loaded from `web/libraries/dlf_aim_3d_viewer/`) mounts on. A settings form (`/admin/config/dlf_aim_3d_viewer`, permission `administer dlf_aim_3d_viewer`) writes the `dlf_aim_3d_viewer.settings` config object, which maps field/bundle IDs, viewer container geometry, gallery selectors, repository URLs and a "lightweight" (viewer-only) mode. When lightweight mode is off, saving a target-bundle entity enqueues a `dlf_aim_3d_viewer_convert` queue item and kicks a detached Drush queue runner; the `ConvertWorker` plugin drives bash/Python/Blender scripts (`scripts/convert.sh`, `render.sh`, `uncompress.sh`) via `ConvertProcessService` to uncompress archives, convert models to GLB, and render preview thumbnails, writing progress onto `field_processing_*` fields. Several authenticated editor API routes support the viewer's in-browser editor: metadata JSON save, thumbnail upload, and METS/MODS XML export. Configuration can also be applied non-interactively with the `drush dlf_aim_3d_viewer:configure` command.

---

- Display an uploaded OBJ/FBX/STL/PLY/DAE/glTF/GLB model interactively on a node or WissKI entity page.
- Replace a plain "download this .glb" file link with an embedded, rotatable 3D viewer.
- Serve a converted GLB derivative in the viewer while keeping the original upload as the source file.
- Run a standalone (non-WissKI) Drupal site as a lightweight 3D viewer with no conversion pipeline.
- Auto-convert a batch of legacy 3D formats (abc, blend, wrl, x3d, 3ds, ifc, gml, xyz) to web-friendly GLB.
- Uncompress archived model uploads (zip, rar, tar, xz, gz) before conversion.
- Generate side/top preview thumbnails of a model with Blender for use as gallery images.
- Show conversion progress (queued / processing / rendering / done) to editors via the `field_processing_progress` field and the status API.
- Configure which file-upload field and which derivative "viewer file name" field the formatter reads.
- Point the viewer at a remote WissKI/repository host for metadata and JSON export via config URLs.
- Tune the viewer container element ID and X/Y scale factors per site.
- Wire the viewer's gallery to an existing block/field by CSS container, class and ID selectors.
- Save per-model viewer metadata (annotations, settings) as a JSON sidecar file from the in-browser editor.
- Upload a model preview thumbnail from the editor and forward it to a WissKI `savePreview` endpoint.
- Export a model record as METS/MODS XML (with IIIF annotation data) for DFG-Viewer / digital-reconstruction interchange.
- Apply a repeatable local-dev or production configuration preset with a single Drush command in CI.
- Override individual settings from the Drush command line (e.g. `--main-url`, `--lightweight`, `--entitybundle`).
- Re-queue conversion automatically whenever a target-bundle entity is created or updated.
- Use a persistent background queue runner so conversions continue after the request that triggered them ends.
- Attach a CSRF token to the viewer's page so its editor AJAX calls to the REST/editor endpoints authenticate.
- Integrate model previews into an existing image gallery/lightbox layout on the entity page.
- Support IFC (BIM) and CityGML source data through the bundled IfcConvert and CityGML2OBJ converters.
- Provide a metadata editor for annotating specific faces of a 3D mesh and exporting those annotations.
