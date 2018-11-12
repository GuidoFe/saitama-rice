#!/bin/bash
status=`nmcli radio wifi`
if [ $status = 'enabled' ]; then
    echo ""
else
    echo '%{A1:nmcli radio wifi on:}%{T3}%{T-}%{A}'
fi
