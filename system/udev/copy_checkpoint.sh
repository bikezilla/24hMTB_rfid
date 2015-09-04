#!/bin/bash

mount /dev/sda1 /home/mtb/flash_mount
cp -R /home/mtb/checkpoint_2 /home/mtb/flash_mount/
umount /home/mtb/flash_mount
