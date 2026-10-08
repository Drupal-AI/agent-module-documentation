# focal_point — agent start

Adds a draggable focal-point crosshair to image fields; ships Image Style effects that crop
around the saved point instead of the center. Depends on core `image` + contrib `crop`.
Stores the point as a relative X,Y % via the Crop API. No global config page.

- Add focal-point effects to image styles + set the field widget → [configure/focal_point.md](configure/focal_point.md)
- Create/read focal-point crop entities in code (`focal_point.manager`) → [api/focal_point.md](api/focal_point.md)
