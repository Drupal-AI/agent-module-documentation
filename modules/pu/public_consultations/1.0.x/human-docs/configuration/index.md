# Configuration

Setting up Public Consultations involves a few pieces: the module's own settings
page, the Public Consultation content type, the webforms you attach to
consultations, and the permissions that decide who can moderate and view
submissions.

## Module settings

Go to **Administration → Configuration → Content → Public Consultations
settings** to configure the module. This is the central settings page for the
consultation feature; adjust it to match how your organisation wants
consultations to behave.

## Creating a consultation

1. Go to **Content → Add content → Public Consultation**.
2. Give the consultation a **title** and fill in the basic information about the
   proposal.
3. Set the **start and end dates** that define the consultation period.
4. Choose or create the **webform** that will collect feedback, and add the
   descriptive details in the field provided.
5. **Save** the consultation.

When you create or edit a webform, you can mark it as a consultation form by
ticking **"Is this a Public Consultation webform?"** in the webform's settings —
that's what makes it available to attach to consultations.

## Redacting sensitive webform answers

Because consultations often gather personal information, the module adds a
redaction control to individual webform elements. To configure it:

1. Edit the webform and open the **Build** tab.
2. Click the element you want to control.
3. Open the element's **Access** tab.
4. At the bottom, choose one of three redaction options:
   - **Visible** — shown to anyone who can view the submission.
   - **Redacted** — replaced with `[REDACTED]` for anyone viewing the submission.
   - **Hidden** — not shown at all to viewers of the submission.

Use *Redacted* or *Hidden* for fields such as names, email addresses, or other
personal data you don't want exposed when submissions are displayed publicly.

## Moderating and viewing submissions

Submissions can be reviewed in several places:

- Through the standard **Webform submissions** interface.
- Via the dedicated **Public Consultation Submissions** view.
- Through the **Submissions** tab on a consultation page, for users with the
  right permission.

To approve a response for public display, edit the submission and tick **"Ready
for public display"**. Only submissions marked this way are surfaced publicly.

## Permissions

Grant these at **People → Permissions** (`/admin/people/permissions`) according
to who should do what:

| Permission | What it allows |
|------------|----------------|
| **View redacted webform elements** | See the real values of elements marked *Redacted* in a consultation submission. |
| **Administer public consultations settings** | Manage the module's configuration settings. |
| **Moderate public consultations submissions** | Moderate submissions, including approving or rejecting them for public display. |
| **View submissions local task** | See the **Submissions** tab on consultation pages. |

Give the moderation and redaction‑viewing permissions only to trusted staff,
since they expose potentially personal information from the public.

## Customising the content type

The Public Consultation content type is a standard Drupal content type, so you
can tailor it at **Structure → Content types → Public Consultation** — adjusting
fields, form display, and view modes just as you would for any other type.
