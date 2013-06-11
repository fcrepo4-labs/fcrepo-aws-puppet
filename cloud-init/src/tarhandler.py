#part-handler
# vi: syntax=python ts=4
#
#    Copyright (C) 2012 Silpion IT-Solutions GmbH
#
#    Author: Malte Stretz <stretz@silpion.de>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License version 3, as
#    published by the Free Software Foundation.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

import os
import StringIO
import tarfile

CACHE_DIR = '/var/cache/cloud'

def list_types():
    return(['application/tar'])

def handle_part(data, ctype, filename, payload):
    if ctype == ('application/tar'):
        dir = "%s/%s" % (CACHE_DIR, os.path.splitext(filename)[0])
        if not os.path.exists(dir):
            os.makedirs(dir)
        buf = StringIO.StringIO(payload)
        tar = tarfile.open(name=filename, fileobj=buf)
        tar.extractall(dir)
        tar.close()
        buf.close()
