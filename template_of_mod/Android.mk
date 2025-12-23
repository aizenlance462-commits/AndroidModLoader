#include <mod/amlmod.h>
#include <mod/logger.h>
#include <mod/config.h>
#include <stdlib.h>
#include <stdio.h>

// 1. SETUP NG MOD INFO
MYMOD(com.madleg.ragdoll, RagdollPhysics, 1.0, Madleg_JuniorDjjr)

// 2. GLOBAL VARIABLES
Config* cfg = NULL;
int iNumSubsteps, iNumIPLInstances;
float fSimulationSpeed, fRagdollLinearDamping, fRagdollAngularDamping;
float fRagdollGravity, fBulletPower, fExplosionPower;
float fSurfaceFriction, fRagDollFriction, fRagDollRestitution;
float fRagDollJointDamping, fRagDollGetUpThreshold;
float fRagDollShapeMargin, fWorldShapeMargin, fDynamicObjectMass;
float fWorldMinX, fWorldMinY, fWorldMaxX, fWorldMaxY;
bool bVehicleShapeUseSpheres, bUseDynamicObjects;

// 3. MAIN FUNCTION
extern "C" void OnModLoad() {
    logger->SetTag("RagdollPhysics");
    logger->Info("Ragdoll Mod Loading...");

    // --- PAGBASA NG INI FILE ---
    cfg = new Config("RagDoll_physics");
    iNumSubsteps = cfg->GetInt("CONFIG", "iNumSubsteps", 5);
    iNumIPLInstances = cfg->GetInt("CONFIG", "iNumIPLInstances", 100000);
    fSimulationSpeed = cfg->GetFloat("CONFIG", "fSimulationSpeed", 1.0f);
    fRagdollLinearDamping = cfg->GetFloat("CONFIG", "fRagdollLinearDamping", 0.05f);
    fRagdollAngularDamping = cfg->GetFloat("CONFIG", "fRagdollAngularDamping", 0.8f);
    fRagdollGravity = cfg->GetFloat("CONFIG", "fRagdollGravity", 1.0f);
    fBulletPower = cfg->GetFloat("CONFIG", "fBulletPower", 1.0f);
    fExplosionPower = cfg->GetFloat("CONFIG", "fExplosionPower", 1.2f);
    fSurfaceFriction = cfg->GetFloat("CONFIG", "fSurfaceFriction", 0.9f);
    fRagDollFriction = cfg->GetFloat("CONFIG", "fRagDollFriction", 0.9f);
    fRagDollRestitution = cfg->GetFloat("CONFIG", "fRagDollRestitution", 0.1f);
    fRagDollJointDamping = cfg->GetFloat("CONFIG", "fRagDollJointDamping", 10.0f);
    fRagDollGetUpThreshold = cfg->GetFloat("CONFIG", "fRagDollGetUpThreshold", 0.5f);
    fRagDollShapeMargin = cfg->GetFloat("CONFIG", "fRagDollShapeMargin", 0.02f);
    fWorldShapeMargin = cfg->GetFloat("CONFIG", "fWorldShapeMargin", 0.01f);
    fDynamicObjectMass = cfg->GetFloat("CONFIG", "fDynamicObjectMass", 20000.0f);
    fWorldMinX = cfg->GetFloat("CONFIG", "fWorldMinX", -4000.0f);
    fWorldMinY = cfg->GetFloat("CONFIG", "fWorldMinY", -4000.0f);
    fWorldMaxX = cfg->GetFloat("CONFIG", "fWorldMaxX", 4000.0f);
    fWorldMaxY = cfg->GetFloat("CONFIG", "fWorldMaxY", 4000.0f);
    bVehicleShapeUseSpheres = cfg->GetBool("CONFIG", "bVehicleShapeUseSpheres", true);
    bUseDynamicObjects = cfg->GetBool("CONFIG", "bUseDynamicObjects", true);
    cfg->Save();

    // --- PAGBASA NG .BIN FILE ---
    char path[256];
    // Inayos ko ang tawag sa config path para iwas error sa compiler
    snprintf(path, sizeof(path), "%s/RagDoll_physics.bin", aml->GetConfigPath()); 

    FILE* file = fopen(path, "rb");
    if (file) {
        fseek(file, 0, SEEK_END);
        long fileSize = ftell(file);
        fseek(file, 0, SEEK_SET);

        void* buffer = malloc(fileSize);
        if (buffer) {
            fread(buffer, fileSize, 1, file);
            logger->Info("RagDoll_physics.bin loaded successfully!");
            
            // Dito idudugtong ang physics engine processing sa susunod
            
            free(buffer); 
        }
        fclose(file);
    } else {
        logger->Error("RagDoll_physics.bin is missing in config folder!");
    }

    logger->Info("Ragdoll Mod initialization finished!");
}

