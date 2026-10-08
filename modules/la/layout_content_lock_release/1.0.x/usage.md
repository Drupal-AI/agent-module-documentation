<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Content Lock Release automatically releases content locks when saving content in Layout Builder.

---

Layout Content Lock Release **releases the content lock when saving in Layout Builder** — when a user saves
their Layout Builder changes, it releases the Content Lock they held on that entity (so the entity isn't left
locked after a successful save), smoothing the LB + Content Lock workflow. It depends on core Node, Layout Builder
and the Content Lock module.

Use it to avoid stuck locks after Layout Builder saves. It is a content-editing/workflow feature; it releases the
current editor's lock after their own successful save (it complements Content Lock, which still governs who can
edit) and has no access-control role. Enable it alongside Content Lock and Layout Builder.

---

- Release the content lock on LB save.
- Avoid entities left locked.
- Smooth the LB + Content Lock workflow.
- Depend on Node + Layout Builder + Content Lock.
- Serve content editing/workflow.
- Release the editor's own lock.
- Complement Content Lock (which still governs editing).
- Release after a successful save.
- Have no access-control role.
- Enable it alongside Content Lock + LB.
- Handle lock release.
- Release locks.
- Configure nothing (behavior).
- Unlock on save.
- Handle the lock.
- Free entities.
- Configure Content Lock.
- Handle the workflow.
- Clear locks.
- Provide lock release.
