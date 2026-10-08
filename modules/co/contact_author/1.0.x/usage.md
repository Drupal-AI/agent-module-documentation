<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Contact Author provides a block with a link to open the contact form of a node's author.

---

Contact Author provides a **block with a link to open the personal contact form of a node's author** — so
readers can message the author of the content they're viewing, via Drupal core's personal contact form. It
depends on core Contact, in the Other package.

Use it to let readers contact content authors. It is a user-engagement feature and it is **implemented safely**
(reviewed): the recipient is derived **server-side from the node's owner** (`$node->getOwnerId()` → core's
`entity.user.contact_form`), **not** from a request parameter — so it can't be pointed at an arbitrary
address; the author's **email is never exposed** in markup (the link carries only the user id and core sends the
message); and actual sending is handled by **core's personal contact form**, which enforces the
`access user contact forms` permission, each user's opt-in, and **hourly flood control** — so this adds no
open-relay/spam path. Configure and place the block.

---

- Link to the node author's contact form.
- Let readers message the author.
- Use core's personal contact form.
- Derive the recipient server-side from the node owner.
- NOT take the recipient from a request parameter.
- Not expose the author's email in markup.
- Delegate sending to core (permission + flood control).
- Add no open-relay/spam path.
- Gate the block by access user contact forms.
- Depend on core Contact.
- Have no access-control role of its own.
- Configure and place the block.
- Handle author contact.
- Provide the link.
- Configure the block.
- Message authors.
- Handle the block.
- Link to authors.
- Contact the author.
- Provide author contact.
