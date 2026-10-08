# Configuration

Group Content Moderation has **no settings form** — you set it up by configuring a
content‑moderation workflow and then granting the group permissions it generates.
There are three steps.

## 1. Set up a content‑moderation workflow

Configure a normal Content Moderation workflow (core's **Editorial** workflow is a
good starting point) at **Configuration → Workflow → Workflows**
(`/admin/config/workflow/workflows`), and apply it to the content types you use as
group content. Nothing special is needed here — the module automatically generates a
group permission for every transition in every content‑moderation workflow, so the
permissions simply appear once your workflow exists.

## 2. Grant the group permissions

On each **Group type's** permissions page, grant the relevant group roles:

- **Use *&lt;workflow&gt;* transition *&lt;transition&gt;*** — lets a member perform
  that specific transition on their group's content. For the Editorial workflow the
  generated permissions include, for example, *use editorial transition
  create_new_draft*, *use editorial transition publish*, and *use editorial
  transition archive*. Grant only the ones each role should have (for instance, give
  a reviewer role just *publish*).
- **View latest version** — lets a member view the pending/latest (unpublished)
  revision of group content: the *Latest version* tab and the moderation queue.
  (This works alongside core's underlying "view unpublished" permissions.)

These are **group permissions**, not global site permissions — they only take effect
within a group the user actually belongs to. That is the whole point: a member's
group role, not their site‑wide role, governs what they can do to their group's
content.

If you add a new transition to a workflow, or create a whole new workflow, its group
permission appears automatically — grant it the same way.

## 3. Optional: the per‑group moderation queue

The module ships an optional view, **"Moderated group content"**, that installs when
both Content Moderation and Group are present. It provides a **Moderated content**
tab in the group menu at `group/{group}/moderated`, listing that group's pending
(draft) revisions. Access is the *view latest version* group permission.

After install, it's worth checking the view's exposed **Moderation state** filters
match your workflow — edit the `moderated_group_content` view and confirm the
"pending/draft" states and the "published" state line up with the states your
workflow actually uses.

The module also adds a Views filter, *group content respect unpublished* (on node
revisions), which respects a member's own/any unpublished permissions plus *view
latest version* — handy if you build your own custom views of group content
revisions.
