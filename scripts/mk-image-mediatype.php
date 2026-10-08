<?php
use Drupal\media\Entity\MediaType;
if (MediaType::load('image')) { print "already exists\n"; return; }
$mt = MediaType::create(['id' => 'image', 'label' => 'Image', 'source' => 'image']);
$mt->save();
$source = $mt->getSource();
$field = $source->createSourceField($mt);
$field->getFieldStorageDefinition()->save();
$field->save();
$mt->set('source_configuration', ['source_field' => $field->getName()])->save();
print "created media.type.image with source field " . $field->getName() . "\n";
