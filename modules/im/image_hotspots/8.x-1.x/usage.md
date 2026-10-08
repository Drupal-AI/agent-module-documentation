<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Hotspots lets editors mark regions of an image with labelled points, creating an annotated image visitors can explore.

---

The pattern answers a need a caption cannot: an image where the information is *where* something is — a product photo labelling its features, a floor plan marking rooms, a diagram naming parts, a team photo naming people, a map with points of interest. To use it, install the module (it depends only on core **Image**), give the roles that should annotate images the **`edit image hotspots`** permission at `/admin/people/permissions`, then on your content type's **Manage display** switch the image field's formatter to **"Image with Hotspots"** and pick an image style. From then on, anyone with the permission who opens a page showing that image sees an **Add hotspot** button under it: they drag a rectangle over the image (a Jcrop selection), type a **title**, optional **description**, optional **link** and whether it should open in a new window, and save. Each hotspot is stored as its own `image_hotspot` entity bound to that field, file and image style, and is shown as a **hover tooltip** or a **click modal** depending on the formatter's *Hotspot style* setting. Titles, descriptions and links are **translatable** per hotspot when you view the image in a non-default language. Because a hotspot is tied to the exact image style it was drawn on, **changing the field's image style hides existing hotspots** (they are not migrated), and deleting the source file or its image style queues the orphaned hotspots for automatic removal on the next cron run. Hotspots scale proportionally as the image is resized, so the annotations stay aligned on responsive layouts. The module is version **8.x-1.0-beta5** (a beta) and runs on core `^10.1 || ^11`.

---

- Label features on a product photograph.
- Mark rooms on a floor plan.
- Identify parts in a technical diagram.
- Name people in a team photograph.
- Mark points of interest on a map.
- Annotate an anatomical illustration.
- Add explanatory labels to any image.
- Build an interactive infographic.
- Label equipment in a workshop photo.
- Annotate a screenshot for documentation.
- Mark locations on a campus image.
- Add clickable regions that link elsewhere.
- Show extra detail in a hover tooltip.
- Show detail in a click-to-open modal dialog.
- Keep labels as translatable text, not baked into the image.
- Explain a technical or engineering drawing.
- Label ingredients in a food photograph.
- Annotate a historical photograph.
- Mark defects on an inspection photo.
- Build a guided, explorable image tour.
- Point out amenities on a venue photo.
- Highlight destinations on a travel map.
