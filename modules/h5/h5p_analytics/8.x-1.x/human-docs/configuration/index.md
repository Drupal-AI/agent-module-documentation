# Configuration

H5P Analytics needs to know where to send the learning data it captures. That's
done on the module's **LRS settings** form, reachable from the **Configuration**
area of the admin menu once the module is enabled.

Open the form as a user with permission to administer site configuration.

## The fields

- **LRS endpoint** — the URL of the Learning Record Store that will receive the
  batched xAPI statements. Use an **HTTPS** URL. Learner data should never travel
  over plain HTTP.
- **LRS credentials** — the authentication details (typically a key/secret or
  username/password) the LRS expects. Treat these as **secrets**: supply them
  from an environment variable or a Key entity rather than hard-coding them, and
  never commit them to version control.
- **Batch size** — how many statements the module gathers into a single batch
  before sending it to the LRS on cron. A larger batch means fewer, bigger
  requests; a smaller batch means more frequent, smaller ones. Tune it to your
  volume of interactions and what your LRS handles comfortably.

Save the form when you're done.

## Don't forget cron

This module does its sending work on **cron**. Statements are captured
immediately, queued, and then batched and delivered to the LRS the next time cron
runs. Make sure cron runs on a regular schedule (a real system cron, not just
occasional page-triggered cron) or data will pile up in the queue and never
reach the LRS.

## A word on the data you're collecting

The statements sent from here contain **learner identifiers and a record of what
each person did** — personal data and a learning record. Make sure your use of
an LRS is covered by your privacy policy and any consent you owe the people being
tracked, and that the LRS itself stores the data appropriately.

## Verify

Have someone interact with H5P content, run `drush cron`, and confirm the
statements arrive in your LRS. If they don't, re-check the endpoint URL, the
credentials, and that cron is actually running.
