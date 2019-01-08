# Create new branch
git br meow

# Push branch
git push -u origin meow

# Merge feature branch to master
# Ensure feature is ontop of master
git co master
git merge feature
git push -f master

# Rebase feature from updated master
# Find the last shared commit
git co feature
git rb --onto origin master d308502

# Delete local branch
git branch -d meow

# Delete remote branch
git push --delete master meow




# Create a new tag
git tag 1.0.0

# Create new annotated tag
git tag 1.0.0 -m "meow"

# Create new annotated tag with multi-line comment
git tag 1.0.0 -m 'meow
meow'

# Push tag
git push origin 1.0.0

# Delete local tag
git tag -d 1.0.0

# Delete remote tag
git push --delete origin 1.0.0


# Fetch remotes
git fetch --all -p

# Ammend commits to new author
git rebase -i XXXXXXX -x "git commit --amend --author 'Nyatella Toast <psyanite@gmail.com>' -CHEAD"
git rebase -i XXXXXXX -x "git commit --amend --author 'Yan Tsui <yan.tsui@corelogic.com.au>' -CHEAD"
