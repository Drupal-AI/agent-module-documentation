# Configuration

Setting up an application flow means building two webforms, linking them with a
workflow, inviting referees, and finally bundling the result. Work through the
steps in order.

## 1. Confirm private files and GhostScript

Before anything else, make sure Drupal's **private file system** is configured and
that the **GhostScript** (`gs`) binary is installed and executable by PHP.
Recommendation PDFs must land in private storage, and GhostScript is what merges
the final PDF. If either is missing, the flow cannot complete.

## 2. Build the application webform

Create the program's application form as an ordinary webform. It can use any
element types you need for the candidate's details.

## 3. Build the letters-of-recommendation webform

Create a **second** webform that accepts a PDF upload for the reference letter.
Two settings on this form are essential:

- Enable **"Allow elements to be populated using query string parameters"** so the
  invitation link can pass values into the form.
- Add a **hidden element with the key `wt`**. This is where the application
  submission's UUID arrives from the invitation link, tying each uploaded letter
  to the right application.

Optionally add a `name` field to record the recommender's name — the module can
surface it in the submission list and use it when naming the bundled PDF.

## 4. Create a workflow linking the two forms

Go to **Structure → Academic Applications Workflows**
(`/admin/structure/academic-applications-workflows`) and add a workflow that links
the application webform to the letters webform. This workflow entity is what the
module uses to connect an application to its recommendation form. The workflow is
exportable configuration.

The module's own settings form lives at
`/admin/config/academic_applications/settings`.

## 5. Invite referees

From an application submission, send each referee a link that carries the
application's UUID in the `wt` parameter, for example:

```
[site:url]form/ar?wt=[webform_submission:uuid]
```

The `wt` value is the application submission's UUID and acts as the **access token**
for that recommender — anyone with the link can upload against that application.
For that reason, distribute these links privately and treat them as sensitive; you
can pass additional values as further query parameters if needed.

## 6. Bundle the final PDF

Open the application submission and use the **Bundle** tab. The module finds the
attached PDFs and merges them with GhostScript into one downloadable file
containing the application answers plus every recommendation letter. If you added
a `name` field, it is used to name the output file.

## Who can do what

- Building the merged bundle is gated by Webform submission access — only users
  who can **view** a submission can bundle it, so restrict submission access
  appropriately.
- The letters form's security rests entirely on the secrecy of the `wt` UUID in
  the invitation link. Keep those links private and audit that uploads land only
  in `private://` storage.

> **A note on the settings-form permission.** The module's settings route
> references a permission (`access academic applications`) that its permissions
> file does not actually declare — only `administer academic applications` is
> declared. In practice this means the settings route fails closed unless that
> permission name is granted. If you cannot reach the settings form, this is
> why; the day-to-day workflow (build forms, create a workflow, bundle) does not
> depend on it.
