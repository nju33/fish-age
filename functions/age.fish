function age -d "Just to get next version tag on git"
  argparse -n age 'M/major' 'm/minor' 'p/patch' -- $argv
  or return 1

  set -l latest_version

  if [ "$argv[1]" != "" ]
    set latest_version $argv[1]
  else
    set -l tags (git tag --sort=-taggerdate | xargs -n 1000)
    set latest_version "v0.0.0"
    for tag in (string split ' ' $tags)
      set -l matches (string match -r 'v\d+\.\d+\.\d+' $tag)
      if test $matches
        set latest_version $tag
        break
      end
    end
  end

  set -l matches (string match -r '(\d+)\.(\d+)\.(\d+)' $latest_version)
  set -l major $matches[2]
  set -l minor $matches[3]
  set -l patch $matches[4]

  if set -lq _flag_patch _flag_p
    echo v{$major}.{$minor}.(math $patch + 1)
    return
  else if set -lq _flag_minor _flag_m
    echo v{$major}.(math $minor + 1).0
    return
  else if set -lq _flag_major _flag_M
    echo v(math $major + 1).0.0
    return
  else
    echo 'Specify one of major|minor|patch as option'
    return 1
  end
end
