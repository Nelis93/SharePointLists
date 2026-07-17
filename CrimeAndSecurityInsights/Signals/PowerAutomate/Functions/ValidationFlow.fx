
@equals(triggerBody()?['ARB_x0028_System_x0029_'],false)

@equals(triggerBody()?['SelectedBoolean'],false)

@equals(length(triggerBody()?['ARR_x0028_System_x0029_']), 0)

@equals(triggerBody()?['ARD_x0028_System_x0029_'],null)


setProperty(
setProperty(
        json('{"Claims": null, "Email": null}'),
        'Claims',
        concat('i:0#.f|membership|',items('For_each_Recipient.notify_to_be_notified'))
    ),
    'Email',
    items('For_each_Recipient.notify_to_be_notified')
)

union(body('Select_value_from_topic'),array(if(contains(outputs('Get_item')?['body/Title'],'Maatschappelijk'),setProperty(json('{"Value": null}'),'Value','newValue'),'')))

if(or(contains(triggerBody()?['ARD_x0028_System_x0029_'],'important pour DirCom'),contains(triggerBody()?['ARD_x0028_System_x0029_'],'belangrijk voor DirCom')),'For DirCom','')

if(
  contains(outputs('Get_item')?['body/Title'], 'Maatschappelijk'),
  union(
    body('Select_value_from_topic'),
    array(setProperty(json('{"Value": null}'), 'Value', 'newValue'))
  ),
  body('Select_value_from_topic')
)

if(
  or(contains(triggerBody()?['ARD_x0028_System_x0029_'],'important pour DirCom'),contains(triggerBody()?['ARD_x0028_System_x0029_'],'belangrijk voor DirCom')),
  union(
    body('Select_Status_2'),
    array(setProperty(json('{"Value": null}'), 'Value', 'For DirCom'))
  ),
  body('Select_Status_2')
)


if(
  and(
    equals(triggerBody()?['text_1'],'nl'),
    equals(body('Get_Request_for_Site_Language'),'1043')
  ),
  'NL_Prim',
  if(
    and(
      equals(triggerBody()?['text_1'],'nl'),
      equals(body('Get_Request_for_Site_Language'),'1036')
    ),
    'NL_Sec',
    if(
      and(
        equals(triggerBody()?['text_1'],'fr'),
        equals(body('Get_Request_for_Site_Language'),'1036')
      ),
      'FR_Prim',
      if(
        and(
          equals(triggerBody()?['text_1'],'fr'),
          equals(body('Get_Request_for_Site_Language'),'1043')
        ),
        'FR_Sec'
        ,'ALL'
      )
    )
  )
)