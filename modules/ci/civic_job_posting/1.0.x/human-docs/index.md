# Civic Job Posting — manual setup guide

**Civic Job Posting** (`civic_job_posting`) helps you publish job listings that
Google can understand. On enable it sets up a **job content type** with the fields
a posting needs, and — the real point of the module — it emits **schema.org
`JobPosting` structured data** on each job page. That structured data makes your
postings eligible to appear in Google's dedicated job-search experience (Google for
Jobs) rich results.

The job content is built from **Paragraphs** and **Field Group** for a structured
editing layout, and the module exposes job data through core **Serialization**,
**REST**, and **Search** so listings are indexable and available to other systems.
In practice you use it on a careers or recruitment section: create jobs as content,
and the JobPosting markup is generated for you.

A couple of practical notes from the project's guidance: make sure Googlebot can
actually crawl your job pages (not blocked by `robots.txt` or a robots meta tag)
and that your host allows reasonably frequent crawling. If you want to use Google's
Indexing API to push updates, that's a separate Google setup (enabling the API,
creating a service account, and verifying ownership in Search Console). The module
itself has no access-control role — its value is the accuracy of the structured
data, so keep the emitted fields true to the real posting.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

## How to use it

After enabling the module (see [Installation](installation/index.md)):

1. Go to **Content → Add content** and choose the job content type the module
   created.
2. Fill in the job's fields — the Paragraphs / Field Group layout groups them for
   easier editing. Keep every value accurate, since these fields feed the
   structured data Google reads.
3. Publish the job. View the page and confirm the `JobPosting` structured data is
   present (you can check it with Google's Rich Results Test).
4. Ensure the page is crawlable — no `robots.txt` block or robots meta tag stopping
   Googlebot — so the posting can be picked up for Google for Jobs.
