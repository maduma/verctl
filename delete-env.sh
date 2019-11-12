ENVS=$( curl -s --request GET --header "PRIVATE-TOKEN: aFjjzLv__NKYkne9fyXw" \
    "https://verctl.maduma.org/api/v4/projects/1/environments" | jq ".[] | .id, .name" )
[ -z "$ENVS" ] && exit 
echo "$ENVS"
echo -n "Type and id: "
read IDS
for ID in $IDS; do
    HASH=$( curl -s --request GET --header "PRIVATE-TOKEN: aFjjzLv__NKYkne9fyXw" \
        "https://verctl.maduma.org/api/v4/projects/1/environments/$ID" | jq .name | tr -d '"' | tr -s '/' '-' )
    curl --request DELETE --header "PRIVATE-TOKEN: aFjjzLv__NKYkne9fyXw" "https://verctl.maduma.org/api/v4/projects/1/environments/$ID"
    echo Environments $ID - $HASH deleted.
    NS=$( kubectl get ns -o name | grep $HASH )
    kubectl delete $NS
    echo Namespace $NS deleted.
done
