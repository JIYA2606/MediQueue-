-- MediQueue starter schema (fictional demo data only).
CREATE DATABASE IF NOT EXISTS mediqueue;
USE mediqueue;

CREATE TABLE IF NOT EXISTS beds (
  bed_id VARCHAR(20) PRIMARY KEY,
  ward VARCHAR(80) NOT NULL,
  bed_type VARCHAR(40) NOT NULL,
  status ENUM('Available','Occupied','Reserved','Maintenance') NOT NULL DEFAULT 'Available',
  current_patient_id VARCHAR(20) NULL
);

CREATE TABLE IF NOT EXISTS patients (
  patient_id VARCHAR(20) PRIMARY KEY,
  patient_name VARCHAR(120) NOT NULL,
  age TINYINT UNSIGNED NOT NULL,
  gender VARCHAR(20) NOT NULL,
  contact VARCHAR(30) NOT NULL,
  department VARCHAR(80) NOT NULL,
  notes TEXT,
  required_ward VARCHAR(80) NOT NULL,
  priority ENUM('Emergency','Critical','Serious','Stable') NOT NULL,
  registered_at DATETIME NOT NULL,
  patient_status ENUM('Waiting','Admitted','Discharged') NOT NULL DEFAULT 'Waiting',
  bed_id VARCHAR(20) NULL,
  INDEX idx_queue (patient_status, priority, registered_at),
  CONSTRAINT fk_patient_bed FOREIGN KEY (bed_id) REFERENCES beds(bed_id) ON DELETE SET NULL
);

ALTER TABLE beds ADD CONSTRAINT fk_bed_patient FOREIGN KEY (current_patient_id) REFERENCES patients(patient_id) ON DELETE SET NULL;

CREATE TABLE IF NOT EXISTS admissions (
  admission_id VARCHAR(30) PRIMARY KEY,
  patient_id VARCHAR(20) NOT NULL,
  bed_id VARCHAR(20) NOT NULL,
  admitted_at DATETIME NOT NULL,
  discharged_at DATETIME NULL,
  CONSTRAINT fk_admission_patient FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
  CONSTRAINT fk_admission_bed FOREIGN KEY (bed_id) REFERENCES beds(bed_id)
);

CREATE TABLE IF NOT EXISTS activity_history (
  event_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  patient_id VARCHAR(20) NOT NULL,
  event_type VARCHAR(30) NOT NULL,
  details VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_history_time (created_at),
  CONSTRAINT fk_history_patient FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);
