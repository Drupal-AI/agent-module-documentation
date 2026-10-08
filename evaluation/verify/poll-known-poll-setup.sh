#!/usr/bin/env bash
# Introspection setup: create a KNOWN poll entity so the agent can inspect the running
# site and report its question and choices. Idempotent: removes any prior eval poll first.
# Marker question is distinctive so cleanup can find and delete it. Paths relative to
# /var/www/html.
set -uo pipefail
cd /var/www/html

drush php:eval '
use Drupal\poll\Entity\Poll;
use Drupal\poll\Entity\PollChoice;
$q = "Which JavaScript framework do you prefer? [eval-known]";
// Remove any prior eval poll with this marker question.
$storage = \Drupal::entityTypeManager()->getStorage("poll");
foreach ($storage->loadByProperties(["question" => $q]) as $p) { $p->delete(); }
$poll = Poll::create([
  "question" => $q,
  "choice" => [
    PollChoice::create(["choice" => "React"]),
    PollChoice::create(["choice" => "Vue"]),
    PollChoice::create(["choice" => "Svelte"]),
  ],
  "status" => 1,
  "active" => 1,
  "runtime" => 0,
]);
$poll->save();
print "setup: created poll " . $poll->id() . " with 3 choices\n";
' 2>/dev/null | grep -a '^setup:'
