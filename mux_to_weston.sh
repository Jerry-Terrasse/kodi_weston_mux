#!/bin/bash
ps aux| grep mux_start.sh| grep bash| awk '{print $2}'| xargs kill -s USR2
