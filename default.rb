# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

user "someuser" do
     comment "default someuser"
     home "/home/someuser"
     shell "/bin/bash"
     password "<hashed password"
end

directory "/home/someuser/.ssh" do
    owner "someuser"
    group "someuser"
    mode "0700"
end

key_list = Array.new
ssh_users = data_bag("users")
ssh_users.each do |id|
        ssh_user = data_bag_item("users", id)
            key_list.push(ssh_user["key"])
end

file "/home/someuser/.ssh/authorized_keys" do
    mode 0600
    owner "someuser"
    group "someuser"
    content key_list.join("\n")
end
