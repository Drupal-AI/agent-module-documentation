<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Book adds book support to JSON:API.

---

JSON:API Book adds support for core Book content to JSON:API — exposing a node's book hierarchy/outline
data through JSON:API, so decoupled/headless front ends can retrieve and render book navigation. It depends
on core JSON:API, in the Web services package.

Use it in decoupled setups that need book structure from JSON:API. It is a web-services feature adding book
data to the API; the exposed data respects **JSON:API's own access control** (it doesn't bypass entity
access — a consumer only sees books/pages they can access). As with any JSON:API extension, review your
resource configuration so it doesn't expose more than intended. It has no access-control role of its own.
Enable it to include book data in JSON:API.

---

- Add Book support to JSON:API.
- Expose book hierarchy/outline via the API.
- Support decoupled book navigation.
- Depend on core JSON:API.
- Retrieve book structure headlessly.
- Render book navigation in a front end.
- Respect JSON:API's own access control.
- Not bypass entity access.
- Review the resource configuration.
- Have no access-control role of its own.
- Enable book data in JSON:API.
- Handle book JSON:API.
- Expose book data.
- Configure the API.
- Add book to JSON:API.
- Handle headless books.
- Include book structure.
- Handle the API.
- Expose book outline.
- Add book support.
