# LMS Certificate — manual setup guide

**LMS Certificate** (`lms_certificate`) lets courses in the Drupal
[LMS](https://www.drupal.org/project/lms) award **completion certificates**. You
associate a certificate with a course, and when a learner completes that course
they can view (and download) their certificate.

The certificate itself can be any entity type, referenced from the course via
Dynamic Entity Reference. To begin with, the only certificate *type* available is
a **PDF certificate**, delivered by the bundled `lms_certificate_fillpdf`
submodule: you upload a fillable PDF form and map its fields to Drupal tokens, so
the learner's name, the course, the completion date, and so on are filled in
automatically. (Support for other certificate types, and for using several types
on one site, may be added later — watch the project's issue queue.)

Because certificates record who completed what, they are **personal /
achievement data**. Set access up so that learners see their *own* certificates,
and handle the underlying completion data with privacy in mind.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it (and the FillPDF submodule), and satisfy the FillPDF service
   requirement.

LMS Certificate has no single central settings form. Setup is a combination of
configuring the FillPDF module/service and referencing a certificate from each
course, described under "How to use it" below.

## How to use it

1. **Set up FillPDF first.** For PDF certificates you must have the **FillPDF**
   module installed and its PDF-generation service successfully configured — see
   Installation. Nothing will generate until FillPDF works.
2. **Create your certificate.** Upload your fillable PDF form via the FillPDF
   workflow and map its form fields to the relevant Drupal tokens (learner name,
   course title, completion date, and so on).
3. **Associate the certificate with a course.** On the LMS course, reference the
   certificate entity you created so that course completion produces that
   certificate.
4. **Check access.** Confirm that a learner can view their own certificate on
   completion and that others cannot see it — this is personal achievement data.

## Where it lives in the admin menu

LMS Certificate does not add its own top-level settings page. You work through the
LMS course configuration (to reference a certificate) and the **FillPDF** module's
configuration (to set up PDF generation and templates).
