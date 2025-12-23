#include <mod/amlmod.h>
#include <mod/config.h>

// 1. I-declare muna natin lahat ng variables base sa .ini file mo
int iNumSubsteps;
float fSimulationSpeed, fRagdollLinearDamping, fRagdollAngularDamping;
float fRagdollGravity, fBulletPower, fExplosionPower;
float fSurfaceFriction, fRagDollFriction, fRagDollRestitution;
float fRagDollJointDamping, fRagDollGetUpThreshold;
bool bVehicleShapeUseSpheres, bUseDynamicObjects;
float fRagDollShapeMargin, fWorldShapeMargin, fDynamicObjectMass;
float fWorldMinX, fWorldMinY, fWorldMaxX, fWorldMaxY;
int iNumIPLInstances;

// Plugin Info
MYMOD(com.user.ragdollport, RagdollPort, 1.0, Madleg & Junior_Djjr)

// 2. Ang Function para basahin ang file
void LoadConfig() {
    // Hahanapin nito ang "RagDoll_physics.ini" sa config folder
    Config* cfg = (Config*)GetConfig()->CreateConfig("RagDoll_physics");

    // --- Binabasa na natin ang [CONFIG] section ---
    
    // Integers (mga buong number)
    iNumSubsteps = cfg->GetInt("CONFIG", "iNumSubsteps", 5);
    iNumIPLInstances = cfg->GetInt("CONFIG", "iNumIPLInstances", 100000);

    // Floats (mga may decimal point)
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
    
    // World Coordinates
    fWorldMinX = cfg->GetFloat("CONFIG", "fWorldMinX", -4000.0f);
    fWorldMinY = cfg->GetFloat("CONFIG", "fWorldMinY", -4000.0f);
    fWorldMaxX = cfg->GetFloat("CONFIG", "fWorldMaxX", 4000.0f);
    fWorldMaxY = cfg->GetFloat("CONFIG", "fWorldMaxY", 4000.0f);

    // Booleans (True or False)
    bVehicleShapeUseSpheres = cfg->GetBool("CONFIG", "bVehicleShapeUseSpheres", true);
    bUseDynamicObjects = cfg->GetBool("CONFIG", "bUseDynamicObjects", true);
    
    // Save para sigurado (optional)
    cfg->Save();
}

extern "C" void OnModLoad() {
    LoadConfig();
    // DITO MO ILALAGAY ANG LOGIC KUNG PAANO GAGAMITIN ANG MGA VALUES NA YAN
}

