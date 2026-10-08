<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Clone pre-fills an entity add form with field values cloned from a source entity, specified via a URL query parameter, with access checks.

---

Field Clone pre-fills an entity add form (e.g. `node/add/page`) by cloning field values from a source
entity — specified via a `fieldclone` URL query parameter like `node:17:field_common` (copy field_common
from node 17) or `node:23:field_source:field_target` (copy into a different target field). This speeds up
creating content that starts from an existing item's values. It depends on the Replicate module and is
configured at `fieldclone.information`.

Use it to build "start from an existing entity" content-creation shortcuts. Importantly for security, it is
**access-checked**: before copying, it verifies the current user's **view access to the source entity**
(`$source_entity->access('view')`) and to the specific **source field** (`$source_field->access('view')`),
returning an error and not copying when access is lacking — so the URL parameter cannot be used to read
field values from entities/fields the user isn't allowed to see. That is the correct behaviour (it doesn't
become an information-disclosure vector). Configure/use the fieldclone parameters as a content-authoring
convenience.

---

- Pre-fill an add form from a source entity.
- Clone field values via a URL parameter.
- Copy field_common from node 17.
- Copy into a different target field.
- Depend on the Replicate module.
- Configure at fieldclone.information.
- Check view access to the source entity.
- Check view access to the source field.
- Not copy when access is lacking.
- Prevent reading inaccessible field values.
- Speed up content creation.
- Start content from an existing item.
- Use fieldclone URL parameters.
- Respect entity + field access.
- Not become an info-disclosure vector.
- Copy values into the add form.
- Configure clone shortcuts.
- Author content faster.
- Clone from existing entities.
- Use as an authoring convenience.
