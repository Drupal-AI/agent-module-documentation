# Configuration

Save Entities is used through two forms rather than a persistent settings page —
you make your choices each time you run a bulk save.

## The two forms

- **Save nodes** — **`/admin/config/content/save-nodes`**.
- **Save media** — **`/admin/config/content/save-media`**.

Access to both is controlled by permissions (see
[Installation](../installation/index.md)); grant them only to trusted
administrators.

## Running a bulk save

On either form:

1. **Choose the types to save.** Select which content types (for nodes) or media
   types (for media) you want to re‑save.
2. **Set the extra options.** You can optionally:
   - restrict the operation to **published content only**, leaving unpublished
     entities untouched;
   - **update the changed date** of each entity as it is re‑saved.
3. **Press save.** The selected entities are re‑saved, which runs their full save
   pipeline — every save hook and processor — so any change that takes effect on
   save is applied across all of them.

## Use it deliberately

Re‑saving runs the complete save pipeline and can **create a new revision** for
each entity, and bulk‑saving many entities at once has a genuine **performance
cost** and can trigger downstream **side effects**. Run it purposefully — for
example after adding a field or a save‑time processor — rather than as a routine
action, and be mindful of how many entities you are selecting. The tool acts with
your own privileges and enforces no access rules of its own beyond the permission
that lets you reach the form.
