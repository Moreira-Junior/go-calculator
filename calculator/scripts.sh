#!/bin/bash

if ps ax | awk '{print $5}' | grep calculator; then
echo "RUNNING"
else
echo "NOT RUNNING"
fi

