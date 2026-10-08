# Configuration

Configuring Flexible Access means defining **access rules** and assigning its
**permissions** — and then verifying, role by role, that the result is exactly
what you intended. Because the module *grants* access (see below), this page is as
much a safety checklist as a how-to.

## The access model in one paragraph

Drupal decides entity access by asking every access handler for a verdict. Each
verdict is **allowed**, **forbidden**, or **neutral** (no opinion). The rules are:
any single **forbidden** wins outright; otherwise, if at least one handler says
**allowed** and none says forbidden, access is granted; if everyone is neutral,
access is denied. Flexible Access plugs in as one of those handlers, and its rules
can return **allowed** — turning a would-be denial (everyone-neutral) into a
grant. It **cannot** override an explicit **forbidden** from core or another
module, but it *can* open up anything that was only denied by default.

The practical consequence: **a broad or careless rule widens who can see or edit
content.** That is the entire risk surface of this module, so treat every rule as
a deliberate exception you are opening.

## Permissions

Flexible Access provides its own permissions. Assign them at **People →
Permissions** (`/admin/people/permissions`) and grant them only to trusted roles —
the ability to define access rules is effectively the ability to hand out access
to content, so it belongs with your administrators, not with content editors.

## Defining rules safely

When you create or edit a rule, keep each one **as narrow as it can be** to
achieve its goal:

1. **Scope tightly.** Target the specific entity type, bundle, and condition you
   mean to open — never a broad "allow" that sweeps in more than the case you are
   solving.
2. **Mind published status.** A rule that grants "view" without accounting for
   published/unpublished state can expose **unpublished or private** content.
   Confirm the rule does not reveal drafts or restricted items.
3. **Test against every role.** After saving a rule, log in (or use a
   role-switching tool) as each role — including **anonymous** — and confirm the
   people who *should not* have access still don't. Do not assume; check.
4. **Check the combined result.** Flexible Access composes with core entity access
   and any other access modules. Verify the outcome with all of them active, not
   just the rule in isolation.
5. **Re-test after changes.** Any later edit to a rule, a role, or another access
   module can change the combined result — re-run your role checks.

## A note on `forbidden`

If your goal is to *deny* access, remember Flexible Access grants rather than
blocks. An explicit **forbidden** from a core or contrib handler will always beat
a Flexible Access "allow", so this module is not the tool for locking content
down — it is the tool for opening specific, well-tested exceptions.
