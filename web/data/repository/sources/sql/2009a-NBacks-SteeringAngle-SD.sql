﻿SELECT
	d.subject_id AS "subject",
	p.annotation AS "annotation",
	stddev_samp(steering_angle) AS "SD.SteeringAngle"

FROM "2009-onrd-pta".daq d INNER JOIN "2009-onrd-pta".protocol_subject p ON (
  p.subject_id = d.subject_id AND
  d.unique_unix_timestamp BETWEEN p.start_timestamp AND p.end_timestamp
)

WHERE (
  p.annotation IN ('2-min-baseline', '0-back verbal', '0-back touch', '2-back') OR
  p.annotation LIKE 'recovery%'
)
GROUP BY d.subject_id, p.annotation
ORDER BY d.subject_id, p.annotation