<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ECA Entity Print adds two ECA action plugins that render a chosen entity or a View to a PDF/document with Entity Print and save the output as a permanent file entity.

---

ECA Entity Print bridges the ECA (Event-Condition-Action) automation module to Entity Print. It ships no routes, permissions, services, or config forms of its own — just two configurable ECA action plugins ("Print file document from entity" and "Print file document from views output") that you drop into an ECA model. When the action runs, it uses Entity Print's print builder and the selected export type (PDF or any registered export type) to render the target, saves the result to the private file scheme as a permanent `file` entity, and exposes that file entity to the rest of the model through a named token. This lets no-code ECA workflows generate documents automatically — for example, produce an invoice PDF when an order is placed, then email or attach the resulting file. It requires the ECA and Entity Print modules (and a working Entity Print engine such as Dompdf or wkhtmltopdf) to be installed and configured. The action honors Entity Print's access checks: the entity action checks the `entity_print.view` route for the target entity, and the View action checks the View display's access.

---

- Generate a PDF from a node (or any fieldable entity) inside an ECA model.
- Generate a document from a View's output inside an ECA model.
- Save the rendered document as a permanent private file entity for later use.
- Reference the generated file entity later in the model via a configurable token name.
- Automatically produce an invoice PDF when an order is completed.
- Create a packing slip or receipt document on a content event.
- Render a certificate or badge PDF when a user finishes a course/quiz.
- Export a contract or agreement entity to PDF on approval.
- Attach a generated PDF to an outgoing email built later in the same ECA model.
- Batch a View of entities into a single document (e.g. a report or catalog).
- Produce a monthly report PDF from a View on a cron-triggered ECA event.
- Pass Views contextual filter arguments (with token support) to scope the rendered document.
- Choose any Entity Print export type registered on the site, not just PDF.
- Give the exported file a token-driven, dynamic file name per run.
- Fall back to an auto-generated unique file name when none is provided.
- Store business documents privately (private:// scheme) rather than in the public files directory.
- Automate document archival by saving file entities from workflow events.
- Combine with other ECA actions to move, rename, or reference the created file.
- Trigger document generation from custom ECA events, entity CRUD, or webform submissions.
- Build a no-code "render entity to PDF and save" step without writing PHP.
- Select a specific View display id to control which display is rendered.
